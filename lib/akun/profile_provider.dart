// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob/helper/const.dart';

import '../aaModel/get_profile.dart';

class ProfileProvider with ChangeNotifier {
  final Dio dio;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String _firstName = '';
  String _lastName = '';
  GetProfile? _profile;

  GetProfile? get profile => _profile;
  String get firstName => _firstName;
  String get lastName => _lastName;

  void setProfile(GetProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  void setFirstName(String name) {
    _firstName = name;
    notifyListeners();
  }

  void setLastName(String name) {
    _lastName = name;
    notifyListeners();
  }

  ProfileProvider(this.dio);

  Future<GetProfile> getProfile(String token) async {
    final getProfileUrl = '$baseUrl/profile';

    try {
      final response = await dio.get(
        getProfileUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        return GetProfile.fromJson(response.data);
      } else {
        throw Exception('Gagal mengambil data profile');
      }
    } catch (e) {
      throw Exception('Terjadi kesalah saat menghubungi server: $e');
    }
  }

  Future<void> updateProfile(
      String token, String firstName, String lastName) async {
    final updateUrl = '$baseUrl/profile/update';
    try {
      final response = await dio.put(
        updateUrl,
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        //berhasil
      } else {
        throw Exception('Gagal memperbaharui profile');
      }
    } catch (e) {
      throw Exception('Gagal : $e');
    }
  }

  // Mengirim pembaruan gambar profil
  Future<void> updateProfileImage(String token, FormData formData) async {
    final updateImageUrl = '$baseUrl/profile/image';
    try {
      final response = await dio.put(
        updateImageUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // berhasil
      } else {
        throw Exception('Failed to update profile image');
      }
    } catch (e) {
      throw Exception('Gagal: $e');
    }
  }
}
