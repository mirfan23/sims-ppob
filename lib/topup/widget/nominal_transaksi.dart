import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../topUpProvider.dart';

class NominalTransaksi extends StatelessWidget {
  const NominalTransaksi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topUpProvider = Provider.of<TopUpProvider>(context);

    return TextField(
      controller: topUpProvider.textEditingController,
      onChanged: topUpProvider.onTextFieldChanged,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        hintText: 'Masukkan nominal Top Up',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: const Icon(Icons.credit_card),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }
}
