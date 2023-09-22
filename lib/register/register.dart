// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/helper/string_extension.dart';

import '../login/auth_provider.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              'Lengkapi data',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'untuk membuat akun',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              onChanged: (value) => authProvider.setEmail(value),
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
              height: 10,
            ),
            TextFormField(
              onChanged: (value) => authProvider.setFirstName(value),
              decoration: InputDecoration(
                labelText: 'Nama Depan',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintStyle: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) => authProvider.setLastName(value),
              decoration: InputDecoration(
                labelText: 'Nama Belakang',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintStyle: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) => authProvider.setPassword(value),
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
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                prefixIcon: Icon(Icons.lock, size: 20),
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintStyle: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final response = await authProvider.register2(
                  email: authProvider.email,
                  firstName: authProvider.firstName,
                  lastName: authProvider.lastName,
                  password: authProvider.password,
                );
                if (response != null && response.status == 0) {
                  // Berhasil registrasi, lakukan navigasi ke hSalaman login
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  // Tampilkan pesan kesalahan
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Registrasi Gagal'),
                        content: Text(response?.message ??
                            'Terjadi kesalahan saat registrasi.'),
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
                'Registrasi',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah memiliki akun? Login'),
                TextButton(
                  onPressed: () {
                    // Navigasi ke halaman login jika sudah memiliki akun
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('disni'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
