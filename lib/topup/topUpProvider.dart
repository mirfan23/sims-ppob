import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sims_ppob/helper/const.dart';

import '../aaModel/topUp.dart';

class TopUpProvider with ChangeNotifier {
  TextEditingController _textEditingController = TextEditingController();
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

  Future<void> performTopUp(BuildContext context, String? token) async {
    final String nominal = textEditingController.text;
    final url = '$baseUrl/topup';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({"top_up_amount": nominal}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final topUpResponse = TopUpResponse.fromJson(responseData);

        if (topUpResponse.status == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Top Up berhasil. Saldo sekarang: ${topUpResponse.data['balance']}'),
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
            content: Text('Terjadi kesalahan saat melakukan top up.'),
          ),
        );
      }
      print(response.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan saat melakukan top up.'),
        ),
      );
      print(e);
    }
  }
}
