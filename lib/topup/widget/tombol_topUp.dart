import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login/auth_provider.dart';
import '../top_up_provider.dart';

class TombolTopUp extends StatelessWidget {
  const TombolTopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      final token = authProvider.token;
      final topUpProvider = Provider.of<TopUpProvider>(context);

      return Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: topUpProvider.isButtonEnabled
              ? () => topUpProvider.performTopUp2(context, token)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            fixedSize: const Size(180, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Top Up',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    });
  }
}
