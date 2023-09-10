// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';


// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   Rxn<User> user = Rxn<User>();
//   final LocalAuthService _localAuthService = LocalAuthService();

//   @override
//   void onInit() async {
//     await _localAuthService.init();
//     final userFromStorage = _localAuthService.getUser();
//     if (userFromStorage != null) {
//       user.value = userFromStorage;
//       Get.offNamed(AppPages.DASHBOARD);
//     } else {
//       user.value = null;
//     }
//     super.onInit();
//   }

//   void signUp(
//       {required String fullName,
//       required String email,
//       required String password}) async {
//     try {
//       EasyLoading.show(
//         status: 'Loading...',
//         dismissOnTap: false,
//       );
//       var result = await RemoteAuthService().signUp(
//         email: email,
//         password: password,
//       );
//       if (result.statusCode == 200) {
//         String token = json.decode(result.body)['jwt'];
//         var userResult = await RemoteAuthService()
//             .createProfile(fullName: fullName, token: token);
//         if (userResult.statusCode == 200) {
//           user.value = userFromJson(userResult.body);
//           await _localAuthService.addToken(token: token);
//           await _localAuthService.addUser(user: user.value!);
//           EasyLoading.showSuccess("Berhasil Mendaftar");
//           Get.offNamed(AppPages.LOGIN);
//         } else {
//           EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!');
//         }
//       } else {
//         EasyLoading.showError(
//             'Username/Email sudah Terpakai, \nSilahkan coba lagi');
//       }
//     } catch (e) {
//       EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!');
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }

//   void signIn({required String email, required String password}) async {
//     try {
//       EasyLoading.show(
//         status: 'Loading...',
//         dismissOnTap: false,
//       );
//       var result = await RemoteAuthService().signIn(
//         email: email,
//         password: password,
//       );
//       if (result.statusCode == 200) {
//         String token = json.decode(result.body)['jwt'];
//         var userResult = await RemoteAuthService().getProfile(token: token);
//         if (userResult.statusCode == 200) {
//           user.value = userFromJson(userResult.body);
//           await _localAuthService.addToken(token: token);
//           await _localAuthService.addUser(user: user.value!);
//           EasyLoading.showSuccess("Selamat Datang di Galeri Lukisan");
//           Get.offNamed(AppPages.DASHBOARD);
//         } else {
//           EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!');
//         }
//       } else {
//         EasyLoading.showError('Username/password Salah');
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//       EasyLoading.showError('Terjadi Kesalahan. Coba Lagi!');
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }

//   void signOut() async {
//     user.value = null;
//     await _localAuthService.clear();
//     Get.offNamed(AppPages.LOGIN);
//   }
// }
