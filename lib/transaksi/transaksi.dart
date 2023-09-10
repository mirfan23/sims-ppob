import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/transaksi/widget/histori_transaksi.dart';
import 'package:sims_ppob/transaksi/widget/saldoTransaksi.dart';
import 'package:sims_ppob/transaksi/widget/trancsactionHistory.dart';

import '../login/authProvider.dart';
import 'transaksiProvider.dart';

class Transaksi extends StatelessWidget {
  const Transaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (authContext, authProvider, _) {
        final transactionProvider = Provider.of<TransactionProvider>(context);
        final token = authProvider.token;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Transaction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SaldoTransaksi(),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Transaksi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TransactionHistoryPage(),
                HistoriTransaksi(
                    transactionProvider: transactionProvider, token: token),
              ],
            ),
          ),
        );
      },
    );
  }
}
