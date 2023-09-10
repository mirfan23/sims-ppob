import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../aaModel/transaction.dart';
import '../aaModel/transaction_history.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionData> transactions = [];

  Future<void> fetchTransactions(String? token) async {
    final url = Uri.parse(
        'https://take-home-test-api.nutech-integrasi.app/transaction/'); // Ganti dengan URL API transaksi Anda

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final parsedData = json.decode(response.body);
        final transactionList = parsedData['data']['records'] as List;

        transactions = transactionList
            .map((data) => TransactionData.fromJson(data))
            .toList();

        notifyListeners();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

Future<TransactionHistoryResponse> fetchTransactionHistory(
    String? token) async {
  final url = Uri.parse(
      'https://take-home-test-api.nutech-integrasi.app/transaction/history');

  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final parsedData = json.decode(response.body);
      final historyResponse = TransactionHistoryResponse.fromJson(parsedData);
      return historyResponse;
    } else {
      throw Exception('Failed to load transaction history');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

class TransactionHistoryProvider extends ChangeNotifier {
  List<TransactionRecord> transactionRecords = [];

  Future<void> loadTransactionHistory(String? token) async {
    try {
      final response = await fetchTransactionHistory(token);

      if (response.status == 0) {
        transactionRecords = response.data.records;
        notifyListeners();
      } else {
        throw Exception(response.message);
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
