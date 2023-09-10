import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/home/widget/menu.dart';
import 'package:sims_ppob/home/widget/saldo.dart';
import 'package:sims_ppob/home/widget/service.dart';
import 'package:sims_ppob/home/widget/voucher.dart';

import 'homeProvider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final services = homeProvider.services;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          leading: Image.asset(
            'assets/images/Logo.png',
          ),
          titleSpacing: 5,
          title: const Text(
            "SIMS PPOB",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Image.asset("assets/images/Profile Photo.png"),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Selamat Datang,',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Kristanto Wibowo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Saldo(),
              const Menu(),
              ServiceGrid(),
              const Text(
                "Temukan Promo Menarik",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Voucher(),
            ],
          ),
        ),
      ),
    );
  }
}
