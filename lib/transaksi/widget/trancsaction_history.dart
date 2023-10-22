import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login/auth_provider.dart';
import '../transaksi_provider.dart';

// Import TransactionHistoryProvider dan model di sini

class TransactionHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      final token = authProvider.token;
      final transactionHistoryProvider =
          Provider.of<TransactionHistoryProvider>(context, listen: false);
      transactionHistoryProvider.loadTransactionHistory(token);
      final transactionRecords = transactionHistoryProvider.transactionRecords;

      return Consumer<TransactionHistoryProvider>(
        builder: (context, provider, _) {
          if (transactionRecords.isEmpty) {
            // Tampilkan pesan jika data transaksi kosong
            return const Center(
              child: Text('No transaction history available.'),
            );
          } else {
            // Tampilkan daftar transaksi jika data tersedia
            return ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactionRecords.length,
              itemBuilder: (context, index) {
                final record = transactionRecords[index];
                return ListTile(
                    title: Text('Amount: \$${record.totalAmount}'),
                    subtitle: Text(record.description),
                    trailing: Text(record.transactionType)
                    // Tambahkan informasi lainnya sesuai kebutuhan
                    );
              },
            );
          }
        },
      );
    });
  }
}
