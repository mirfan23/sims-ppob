// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../aaModel/balance.dart';
import '../aaModel/banner.dart';
import '../aaModel/services.dart';
import '../helper/const.dart';

class HomeProvider with ChangeNotifier {
  final dio = Dio();
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

  Future<BannerResponse> fetchBanners2(String? token) async {
    final String bannerUrl = '$baseUrl/banner';

    try {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(bannerUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return BannerResponse.fromJson(responseData);
      } else {
        print('Failed to load banners. Status code: ${response.statusCode}');
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      print('Error while fetching banner: $e');
      throw Exception('Failed to load banners 2');
    }
  }

  Future<void> fetchBalance2(String? token) async {
    final balanceUrl = '$baseUrl/balance';

    try {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(balanceUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
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

  Future<void> fetchService2(String? token) async {
    final serviceUrl = '$baseUrl/services';

    try {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(serviceUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        if (data['status'] == 0) {
          final List<dynamic> serviceData = data['data'];
          final List<Service> serviceList = serviceData
              .map((serviceData) => Service.fromJson(serviceData))
              .toList();

          _services = serviceList;
          notifyListeners();
          print(response.data);
        } else {
          throw Exception('Failed to load service');
        }
      } else {
        throw Exception('Failed to load services 2');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load services 3');
    }
  }
}
