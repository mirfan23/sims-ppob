import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../aaModel/login.dart';
import '../aaModel/registrasi.dart';
import '../helper/const.dart';

class AuthProvider with ChangeNotifier {
  final dio = Dio();
  var client = http.Client();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  String _emailLogin = '';
  String _passwordLogin = '';
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
  String get emailLogin => _emailLogin;
  String get passwordLogin => _passwordLogin;
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

  void setEmailLogin(String value) {
    _emailLogin = value;
    _validateForm();
    notifyListeners();
  }

  void setPasswordLogin(String value) {
    _passwordLogin = value;
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

  Future<LoginResponse?> logIn2({
    required String email,
    required String password,
  }) async {
    final String logInUrl = '$baseUrl/login';

    final Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    try {
      final response = await dio.post(logInUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          data: requestBody);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final logInResponse = LoginResponse.fromJson(responseData);

        //simpan token
        setToken(logInResponse.data?.token ?? '');
        print('$token');

        return logInResponse;
      } else {
        EasyLoading.showError('Terjadi kesalahan. Coba Lagi 1');
      }
    } catch (e) {
      EasyLoading.showError('Terjadi kesalahan. Coba Lagi 2');
    }
    return null;
  }

  Future<RegisterResponse> register2({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final String registerUrl = '$baseUrl/registration';

    final Map<String, dynamic> requestBody = {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };

    try {
      final response = await dio.post(
        registerUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: requestBody,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return RegisterResponse.fromJson(responseData);
      } else {
        print(response.data);
        throw Exception('Gagal mendaftar.');
      }
    } catch (e) {
      EasyLoading.showError('Terjadi Kesalahan. Coba Lagi! : $e');
      throw Exception('Terjadi Kesalahan. Coba Lagi! : $e');
    }
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
