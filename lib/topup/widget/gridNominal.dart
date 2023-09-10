import 'package:flutter/material.dart';

import '../../helper/myList.dart';
import '../topUpProvider.dart';

class GridNominal extends StatelessWidget {
  const GridNominal({
    super.key,
    required this.topUpProvider,
  });

  final TopUpProvider topUpProvider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 3,
        crossAxisSpacing: 7,
        mainAxisSpacing: 18,
      ),
      itemCount: MyList.nominal.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          topUpProvider.setSelectedNominal(MyList.nominal[index]);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              MyList.nominal[index],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
