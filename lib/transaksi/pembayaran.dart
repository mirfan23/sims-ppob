// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:sims_ppob/helper/const.dart';

// import '../aaModel/transaction.dart';

// class TransactionPage extends StatelessWidget {
//   final String serviceCode;
//   final String? token;

//   const TransactionPage({
//     required this.serviceCode,
//     required this.token,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Future<Transaction> fetchTransactionData() async {
//       try {
//         final apiUrl = '$baseUrl/transaction';

//         final response = await http.get(
//           Uri.parse(apiUrl),
//           headers: {
//             'Authorization': 'Bearer $token', // Mengirim token di header
//           },
//         );
//         print(response.statusCode);
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           return Transaction.fromJson(responseData);
//         } else {
//           throw Exception('Gagal mengambil data transaksi');
//         }
//       } catch (e) {
//         print(e);
//         throw Exception('Terjadi kesalahan saat mengambil data transaksi: $e');
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Transaksi - $serviceCode'),
//       ),
//       body: FutureBuilder<Transaction>(
//         future: fetchTransactionData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData) {
//             return Text('Tidak ada data transaksi.');
//           } else {
//             final transaction = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Invoice Number: ${transaction.data.invoiceNumber}'),
//                   Text('Service Code: ${transaction.data.serviceCode}'),
//                   Text('Service Name: ${transaction.data.serviceName}'),
//                   Text('Transaction Type: ${transaction.data.transactionType}'),
//                   Text('Total Amount: ${transaction.data.totalAmount}'),
//                   Text(
//                       'Created On: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(transaction.data.createdOn)}'),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:sims_ppob/helper/const.dart';
import 'package:sims_ppob/transaksi/widget/saldoTransaksi.dart';
import 'dart:convert';

import '../aaModel/transaction.dart';
import '../login/authProvider.dart';

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

    final url =
        '$baseUrl/transaction'; // Gantilah URL API sesuai dengan kebutuhan Anda

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
          // Transaksi berhasil
          // Tampilkan informasi transaksi kepada pengguna sesuai kebutuhan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Transaksi berhasil. Invoice Number: ${transactionResponse.data.invoiceNumber}'),
            ),
          );
        } else {
          // Transaksi gagal
          // Tampilkan pesan kesalahan kepada pengguna sesuai kebutuhan
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
