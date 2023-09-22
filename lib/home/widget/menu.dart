import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/helper/myList.dart';

import '../../login/auth_provider.dart';
import '../home_provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      final token = authProvider.token;

      return Consumer<HomeProvider>(
        builder: (context, serviceProvider, _) {
          final services = serviceProvider.services;

          return Container(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<void>(
              future: serviceProvider.fetchService2(token),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(MyList.icon[index]),
                              radius: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text(' ');
                }
              },
            ),
          );
        },
      );
    });
  }
}
