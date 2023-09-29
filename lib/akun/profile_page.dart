// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login/auth_provider.dart';
import 'profile_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = ProfileProvider(Dio());

    return Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
      final token_ = authProvider.token;
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
          child: Center(
            child: Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                final profile = provider.profile;
                if (profile == null) {
                  return const CircularProgressIndicator();
                } else {
                  // Tampilkan data profil di sini
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(profile.data.profileImage),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: profile.data.email,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: provider.firstNameController,
                        // initialValue: profile.data.firstName,
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
                          profileProvider.setFirstName(value);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: provider.lastNameController,
                        // initialValue: profile.data.lastName,
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
                          profileProvider.setLastName(value);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final token = token_;
                            final firstName = profileProvider.firstName;
                            final lastName = profileProvider.lastName;

                            await profileProvider.updateProfile(
                                token!, firstName, lastName);

                            final profile =
                                await profileProvider.getProfile(token);
                            Provider.of<ProfileProvider>(context, listen: false)
                                .setProfile(profile);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Gagal mengupdate profil: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            print('Gagal update profile: $e');
                          }
                        },
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
                        onPressed: () async {
                          // try {
                          //   final token =
                          //       token_;
                          //   final imageFile = File(
                          //       'path_to_image.jpg'); // Ganti dengan lokasi gambar Anda
                          //   final formData = FormData.fromMap({
                          //     'file': await MultipartFile.fromFile(
                          //         imageFile.path,
                          //         filename: 'profile_image.jpg'),
                          //   });

                          //   await profileProvider.updateProfileImage(
                          //       token!, formData);

                          //   // Perbarui data profil setelah pembaruan gambar berhasil
                          //   final profile =
                          //       await profileProvider.getProfile(token);
                          //   Provider.of<ProfileProvider>(context, listen: false)
                          //       .setProfile(profile);
                          // } catch (e) {
                          //   print('Error updating profile image: $e');
                          //   // Handle kesalahan dengan menampilkan pesan kesalahan atau mengambil tindakan yang sesuai.
                          // }
                        },
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
                        child: const Text('Edit Gambar',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout();
                          AuthProvider().logout();
                          Navigator.pushReplacementNamed(context, '/login');
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
                        child: const Text('Log Out',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              final token = token_; // Ganti dengan token autentikasi Anda
              final profile = await profileProvider.getProfile(token!);
              Provider.of<ProfileProvider>(context, listen: false)
                  .setProfile(profile);
            } catch (e) {
              print('Error fetching profile: $e');
              // Handle kesalahan dengan menampilkan pesan kesalahan atau mengambil tindakan yang sesuai.
            }
          },
          child: const Icon(Icons.refresh),
        ),
      );
    });
  }
}
