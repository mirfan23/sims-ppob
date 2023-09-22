import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/home/home_provider.dart';

import '../../login/auth_provider.dart';

class SaldoTransaksi extends StatefulWidget {
  const SaldoTransaksi({
    super.key,
  });

  @override
  _SaldoTransaksiState createState() => _SaldoTransaksiState();
}

class _SaldoTransaksiState extends State<SaldoTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
      final balanceProvider = Provider.of<HomeProvider>(context);
      final int saldo = balanceProvider.balance;
      final bool isBalanceVisible = balanceProvider.isBalanceVisible;
      String saldoTopUpText = isBalanceVisible ? 'Rp $saldo' : 'Rp ******';
      final token = authProvider.token;

      return Container(
        height: 150,
        width: 5000,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('assets/images/Background_Saldo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SaldoTopUp Anda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                saldoTopUpText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              InkWell(
                onTap: () {
                  balanceProvider.fetchBalance2(token);
                },
                child: Row(
                  children: [
                    const Text(
                      'Lihat SaldoTopUp',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(
                        isBalanceVisible
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        balanceProvider.fetchBalance2(token);
                        balanceProvider.toggleBalanceVisibility();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
