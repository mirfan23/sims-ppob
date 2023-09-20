// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sims_ppob/helper/const.dart';
import 'package:dio/dio.dart';

import '../aaModel/topUp.dart';

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
          content: Text('Terjadi kesalahan saat melakukan top up2.'),
        ),
      );
      print(e);
    }
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
