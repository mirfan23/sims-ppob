import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/home/homeProvider.dart';

import '../../login/authProvider.dart';

class Saldo extends StatefulWidget {
  const Saldo({
    super.key,
  });

  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
      final balanceProvider = Provider.of<HomeProvider>(context);
      final int saldo = balanceProvider.balance;
      final bool isBalanceVisible = balanceProvider.isBalanceVisible;
      String SaldoText = isBalanceVisible ? 'Rp $saldo' : 'Rp ******';
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
                'Saldo Anda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                SaldoText,
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
                      'Lihat Saldo',
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
