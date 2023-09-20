import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/home/homeProvider.dart';

import '../../aaModel/banner.dart';
import '../../login/authProvider.dart';

class Voucher extends StatelessWidget {
  const Voucher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
      final bannerProvider = Provider.of<HomeProvider>(context);
      final token = authProvider.token;

      return FutureBuilder<BannerResponse>(
        future: bannerProvider.fetchBanners2(token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Text('Tidak ada data banner.');
          } else {
            final banners = snapshot.data!.data;

            return SizedBox(
              height: 150,
              width: 500,
              child: CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (_, index, __) => carditem(banners, index),
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 2 / 3,
                  viewportFraction: 0.8,
                  autoPlay: true,
                ),
              ),
            );
          }
        },
      );
    });
  }

  Widget carditem(List<BannerItem> banners, int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Image.network(
        banners[index].bannerImage, // Menggunakan URL gambar dari data banner
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
