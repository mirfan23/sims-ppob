// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/helper/string_extension.dart';
import 'auth_provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              constraints: const BoxConstraints(maxWidth: 180),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 30,
                  ),
                  const Text(
                    'SIMS PPOB',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Masuk atau buat akun',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'untuk memulai',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              onChanged: (value) => authProvider.setEmailLogin(value),
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                } else if (!value.isValidEmail) {
                  return 'Email tidak valid';
                }
                return null; // Tidak ada kesalahan
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              onChanged: (value) => authProvider.setPasswordLogin(value),
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    authProvider.togglePasswordVisibility();
                  },
                  icon: Icon(
                    authProvider.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !authProvider.isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                } else if (value.length < 8) {
                  return 'Password harus memiliki setidaknya 8 karakter';
                }
                return null; // Tidak ada kesalahan
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await authProvider.logIn2(
                  email: authProvider.emailLogin,
                  password: authProvider.passwordLogin,
                );
                if (response != null && response.status == 0) {
                  // Berhasil login, lakukan navigasi ke halaman selanjutnya
                  Navigator.pushReplacementNamed(context, '/dashboard');
                } else {
                  // Tampilkan pesan kesalahan
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Login Gagal'),
                        content: Text(response?.message ??
                            'Terjadi kesalahan saat login.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              // : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(
                  200,
                  50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum punya akun? Register',
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: const Text(
                    'di sini',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
