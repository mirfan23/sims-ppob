import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/dashboard/dashboard.dart';
import 'package:sims_ppob/home/widget/menu.dart';
import 'package:sims_ppob/home/widget/service.dart';
import 'package:sims_ppob/register/register.dart';
import 'package:sims_ppob/topup/topUpProvider.dart';
import 'package:sims_ppob/transaksi/transaksiProvider.dart';
import 'package:sims_ppob/transaksi/widget/trancsactionHistory.dart';

import 'home/home.dart';
import 'home/homeProvider.dart';
import 'login/authProvider.dart';
import 'login/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TopUpProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => TransactionHistoryProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        // home: Services(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginView(),
          '/register': (context) => RegisterView(),
          '/home': (context) => const Home(),
          '/dashboard': (context) => DashBoard(),
          '/service': (context) => TransactionHistoryPage(),
        },
        builder: EasyLoading.init(),
      ),
    ),
  );
}