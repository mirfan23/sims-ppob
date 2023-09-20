// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../aaModel/topUp.dart';
import '../helper/const.dart';

class TopUpProvider with ChangeNotifier {
  final dio = Dio();
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedNominal = '';
  bool isButtonEnabled = false;

  TextEditingController get textEditingController => _textEditingController;
  String get selectedNominal => _selectedNominal;

  void setSelectedNominal(String nominal) {
    _selectedNominal = nominal;
    _textEditingController.text = nominal;
    notifyListeners();
  }

  void onTextFieldChanged(String text) {
    isButtonEnabled = text.isNotEmpty;
    notifyListeners();
  }

  Future<void> performTopUp2(BuildContext context, String? token) async {
    final String nominal = textEditingController.text;
    final topUpurl = '$baseUrl/topup';

    try {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response =
          await dio.post(topUpurl, data: {"top_up_amount": nominal});

      if (response.statusCode == 200) {
        final topUpResponse = TopUpResponse.fromJson(response.data);

        if (topUpResponse.status == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Top Up berhasi. Saldo Sekarang: ${topUpResponse.data['balance']}'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(topUpResponse.message),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('terjadi kesalahan saat melakukan top up'),
          ),
        );
      }
      print(response.data);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat melakukan top up2'),
        ),
      );
      print(e);
    }
  }
}
