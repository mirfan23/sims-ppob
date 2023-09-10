import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaksiProvider.dart';

class HistoriTransaksi extends StatelessWidget {
  const HistoriTransaksi({
    super.key,
    required this.transactionProvider,
    required this.token,
  });

  final TransactionProvider transactionProvider;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: transactionProvider.fetchTransactions(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Menampilkan indikator loading
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final transactions = transactionProvider.transactions;

          return ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemBuilder: (BuildContext context, int index) {
              final transaction = transactions[index];
              return Container(
                padding: const EdgeInsets.only(
                  top: 27,
                  right: 10,
                  left: 10,
                ),
                height: 100,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.totalAmount.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.green,
                          ),
                        ),
                        Spacer(),
                        Text(
                          transaction.serviceCode,
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('dd/MMMM/yyyy').format(transaction.createdOn),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
