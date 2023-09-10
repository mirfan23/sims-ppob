// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../aaModel/balance.dart';
import '../aaModel/banner.dart';
import '../aaModel/services.dart';
import '../helper/const.dart';

class HomeProvider with ChangeNotifier {
  int _balance = 0;
  int get balance => _balance;
  bool _isBalanceVisible = false;
  bool get isBalanceVisible => _isBalanceVisible;
  List<Service> _services = [];
  List<Service> get services => _services;

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  Future<BannerResponse> fetchBanners(String? token) async {
    final String apiUrl = '$baseUrl/banner';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return BannerResponse.fromJson(responseData);
    } else {
      print('Failed to load banners. Status code: ${response.statusCode}');
      throw Exception('Failed to load banners');
    }
  }

  Future<void> fetchBalance(String? token) async {
    final apiUrl = '$baseUrl/balance';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final balanceModel = BalanceModel.fromJson(responseData);

        _balance = balanceModel.data.balance;
        notifyListeners();
      } else {
        print('Failed to load balance. Status code: ${response.statusCode}');
        throw Exception('Failed to load balance');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load balance');
    }
  }

  Future<void> fetchServices(String? token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/services'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 0) {
          final List<dynamic> serviceData = data['data'];
          final List<Service> serviceList = serviceData
              .map((serviceData) => Service.fromJson(serviceData))
              .toList();

          _services = serviceList;
          notifyListeners();
          print(response.body);
        } else {
          // print(response.body);
          throw Exception('Failed to load services');
        }
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      // print(e);
      throw e;
    }
  }
}
