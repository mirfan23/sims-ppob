import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../aaModel/services.dart';
import '../../login/auth_provider.dart';
import '../../transaksi/pembayaran.dart';
import '../home_provider.dart';

class ServiceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<HomeProvider>(context);
    final services = serviceProvider.services;

    return SizedBox(
      height: 150,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];

          return ServiceCard(service: service);
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: InkWell(
          onTap: () {
            final String serviceCode = service.serviceCode;
            final int totalAmount = service.serviceTariff;

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Transaksi2(
                  serviceCode: serviceCode,
                  totalAmount: totalAmount,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                service.serviceIcon,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Text(
                  service.serviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
