import 'package:flutter/material.dart';
import 'package:sims_ppob/akun/profile_page.dart';

import '../home/home.dart';
import '../topup/top_up.dart';
import '../transaksi/transaksi.dart';

class MyList {
  static List icon = [
    const AssetImage("assets/images/PBB.png"),
    const AssetImage("assets/images/Listrik.png"),
    const AssetImage("assets/images/Pulsa.png"),
    const AssetImage("assets/images/PDAM.png"),
    const AssetImage("assets/images/PGN.png"),
    const AssetImage("assets/images/Televisi.png"),
    const AssetImage("assets/images/Musik.png"),
    const AssetImage("assets/images/Game.png"),
    const AssetImage("assets/images/Makanan.png"),
    const AssetImage("assets/images/Kurban.png"),
    const AssetImage("assets/images/Zakat.png"),
    const AssetImage("assets/images/Data.png"),
  ];
  static List banner = [
    const AssetImage("assets/images/Banner 1.png"),
    const AssetImage("assets/images/Banner 2.png"),
    const AssetImage("assets/images/Banner 3.png"),
    const AssetImage("assets/images/Banner 4.png"),
    const AssetImage("assets/images/Banner 5.png"),
  ];
  static List<String> nominal = [
    '10000',
    '20000',
    '50000',
    '100000',
    '250000',
    '500000',
  ];

  static List navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.local_atm_outlined,
      "non_active_icon": Icons.local_atm_outlined,
      "label": "TopUp",
    },
    {
      "active_icon": Icons.credit_card,
      "non_active_icon": Icons.credit_card,
      "label": "Transaction",
    },
    {
      "active_icon": Icons.account_circle_outlined,
      "non_active_icon": Icons.account_circle_rounded,
      "label": "Akun",
    }
  ];

  static List<Widget> fragmentScreen = [
    const Home(),
    const TopUp(),
    const Transaksi(),
    // Akun(),
    ProfilePage(),
  ];
}
