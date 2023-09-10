import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../aaModel/profile.dart';

Future<ProfileResponse> updateProfileImage(String token, File imageFile) async {
  final url = Uri.parse(
      'https://take-home-test-api.nutech-integrasi.app/profile/image');

  try {
    final request = http.MultipartRequest('PUT', url);
    request.headers['Authorization'] = 'Bearer $token';

    if (imageFile != null) {
      final stream = http.ByteStream(imageFile.openRead());
      final length = await imageFile.length();

      final multipartFile = http.MultipartFile('file', stream, length,
          filename: 'profile_image.jpg');

      request.files.add(multipartFile);
    }

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(responseString);
      return ProfileResponse.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to update profile image');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

Future<ProfileResponse> updateProfile(
    String email, String firstName, String lastName) async {
  final url = Uri.parse(
      'https://take-home-test-api.nutech-integrasi.app/profile/update');

  try {
    final body = json.encode({
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.put(url, headers: headers, body: body);
    final responseString = response.body;

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(responseString);
      return ProfileResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to update profile');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}
