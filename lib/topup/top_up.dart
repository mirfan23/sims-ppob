import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/topup/top_up_provider.dart';
import 'package:sims_ppob/topup/widget/grid_nominal.dart';
import 'package:sims_ppob/topup/widget/nominal_transaksi.dart';
import 'package:sims_ppob/topup/widget/saldo_topUp.dart';
import 'package:sims_ppob/topup/widget/tombol_topUp.dart';

class TopUp extends StatelessWidget {
  const TopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TopUpProvider(),
      child: _TopUpContent(),
    );
  }
}

class _TopUpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topUpProvider = Provider.of<TopUpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Up',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SaldoTopUp(),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Silahkan Masukkan,',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Text(
              'Nominal Top Up',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const NominalTransaksi(),
            const SizedBox(
              height: 20,
            ),
            GridNominal(topUpProvider: topUpProvider),
            const SizedBox(
              height: 20,
            ),
            const TombolTopUp(),
          ],
        ),
      ),
    );
  }
}
