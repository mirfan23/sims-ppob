import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/helper/myList.dart';

import '../../login/authProvider.dart';
import '../homeProvider.dart';

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
              future: serviceProvider.fetchServices(token),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const CircularProgressIndicator();
                // } else
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
                      // final service = services[index];
                      // final serviceIcon = service.serviceIcon;
                      // final serviceName = service.serviceName;
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(MyList.icon[index]),
                              radius: 20,
                            ),
                            // const SizedBox(
                            //   height: 8,
                            // ),
                            // Text(
                            //   serviceName,
                            //   style: const TextStyle(fontSize: 11),
                            // ),
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
