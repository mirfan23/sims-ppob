import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:sims_ppob/helper/const.dart';
import 'package:sims_ppob/transaksi/widget/saldo_transaksi.dart';
import 'dart:convert';

import '../aaModel/transaction.dart';
import '../login/auth_provider.dart';

class Transaksi2 extends StatelessWidget {
  final String serviceCode;
  final int totalAmount;

  const Transaksi2({
    required this.serviceCode,
    required this.totalAmount,
  });

  Future<void> _performTransaction(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;

    final url = '$baseUrl/transaction';

    final requestBody = {
      "service_code": serviceCode,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final transactionResponse = TransactionResponse.fromJson(responseData);

        if (transactionResponse.status == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Transaksi berhasil. Invoice Number: ${transactionResponse.data.invoiceNumber}'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(transactionResponse.message),
            ),
          );
        }
      } else {
        // Handle kesalahan lainnya jika diperlukan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan saat melakukan transaksi.'),
          ),
        );
      }
    } catch (e) {
      // Tangani kesalahan koneksi atau lainnya jika diperlukan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat melakukan transaksi.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaksi - $serviceCode', // Menampilkan service_code
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SaldoTransaksi(),
              Text(
                'Total Amount: $totalAmount', // Tampilkan totalAmount
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: TextEditingController(
                    text: totalAmount
                        .toString()), // Set nilai awal teks dari totalAmount
                readOnly: true, // Agar teks tidak dapat diubah
                decoration: InputDecoration(
                  labelText: 'Total Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _performTransaction(context);
                  },
                  child: Text('Lakukan Transaksi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
