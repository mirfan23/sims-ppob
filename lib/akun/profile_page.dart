import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_provider.dart';
import '../login/auth_provider.dart';
import 'profile_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider =
        ProfileProvider(Dio()); // Inisialisasi ApiService sesuai kebutuhan Anda
    return Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
      final _token = authProvider.token;
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
                  // Data belum diambil, tampilkan loading atau pesan lainnya
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
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        // onChanged: (value) {
                        //   setState(() {
                        //     _email = value;
                        //   });
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: profile.data.firstName,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        // onChanged: (value) {
                        //   setState(() {
                        //     _email = value;
                        //   });
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: profile.data.lastName,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        // onChanged: (value) {
                        //   setState(() {
                        //     _email = value;
                        //   });
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        // onPressed: _updateProfile,
                        onPressed: () {},
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
              final token = _token; // Ganti dengan token autentikasi Anda
              final profile = await profileProvider.getProfile(token!);
              Provider.of<ProfileProvider>(context, listen: false)
                  .setProfile(profile);
            } catch (e) {
              print('Error fetching profile: $e');
              // Handle kesalahan dengan menampilkan pesan kesalahan atau mengambil tindakan yang sesuai.
            }
          },
          child: Icon(Icons.refresh),
        ),
      );
    });
  }
}
