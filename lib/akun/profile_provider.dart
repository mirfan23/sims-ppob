import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob/helper/const.dart';

import '../aaModel/get_profile.dart';

class ProfileProvider with ChangeNotifier {
  final Dio dio;
  GetProfile? _profile;

  GetProfile? get profile => _profile;

  void setProfile(GetProfile profile) {
    _profile = profile;
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

  // Future<ProfileResponse> updateProfileImage(
  //     String? token, File imageFile) async {
  //   final updateImageUrl = '$baseUrl/profile/image';

  //   try {
  //     final requ
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
