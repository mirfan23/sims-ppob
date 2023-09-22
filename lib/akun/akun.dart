// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/akun/akun_provider.dart';

import '../login/auth_provider.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _profileImage = '';

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile.path;
      });
    }
  }

  Future<void> _updateProfile() async {
    final token = Provider.of<AuthProvider>(context, listen: false).getToken();

    try {
      // Update gambar profil jika _profileImage tidak kosong
      if (_profileImage.isNotEmpty) {
        final profileImageResponse =
            await updateProfileImage(token!, File(_profileImage));
      }

      // Update first name dan last name
      final profileResponse =
          await updateProfile(_email, _firstName, _lastName);

      // Setelah berhasil mengupdate, perbarui nilai variabel
      setState(() {
        _email = profileResponse.email;
        _firstName = profileResponse.firstName;
        _lastName = profileResponse.lastName;
      });

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update Profile berhasil'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengupdate profil'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text(
          'Profile Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage.isNotEmpty
                    ? FileImage(File(_profileImage))
                    : _profileImage.isNotEmpty
                        ? CachedNetworkImageProvider(_profileImage)
                            as ImageProvider
                        : const AssetImage('assets/images/Profile Photo-1.png'),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: _email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: _firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _firstName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: _lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(
                  200,
                  50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Edit Profile',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                AuthProvider().logout();
                Navigator.pushReplacementNamed(context, '/login');
                // Navigator.pushReplacementNamed(context, '/service');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(
                  200,
                  50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  const Text('Log Out', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
