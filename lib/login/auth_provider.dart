import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../aaModel/login.dart';
import '../aaModel/registrasi.dart';
import '../helper/const.dart';

class AuthProvider with ChangeNotifier {
  var client = http.Client();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  bool _isValid = false;
  bool _isPasswordVisible = false;
  bool isValidPassword() {
    return password.length >= 8;
  }

  String? _token;

  String? get token => _token;
  String get email => _email;
  String get password => _password;
  String get firstName => _firstName;
  String get lastName => _lastName;
  bool get isValid => _isValid;
  bool get isPasswordVisible => _isPasswordVisible;

  void setEmail(String value) {
    _email = value;
    _validateForm();
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _validateForm();
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    _validateForm();
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    _validateForm();
    notifyListeners();
  }

  void _validateForm() {
    _isValid = _email.isNotEmpty &&
        _password.isNotEmpty &&
        _firstName.isNotEmpty &&
        _lastName.isNotEmpty;
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  // Fungsi untuk mengubah isPasswordVisible
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  String? getToken() {
    return _token;
  }

  Future<LoginResponse?> logIn({
    required String email,
    required String password,
  }) async {
    final String apiUrl = '$baseUrl/login';

    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final loginResponse = LoginResponse.fromJson(responseData);

        // Simpan token ke dalam variabel _token
        setToken(loginResponse.data?.token ?? '');
        print('$token');

        return loginResponse;
      } else {
        EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!');
      return null;
    }
  }

  Future<RegisterResponse> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final String apiUrl = '$baseUrl/registration';

    final Map<String, String> requestBody = {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return RegisterResponse.fromJson(responseData);
      } else {
        print(response.body);
        throw Exception('Failed to register');
      }
    } catch (e) {
      EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!: $e');
      // return null;
      throw Exception('An error occurred: $e');
    }
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
