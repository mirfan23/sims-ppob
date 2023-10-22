import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/my_list.dart';
import '../home/home_controller.dart';

class DashBoard extends StatelessWidget {
  final controller = Get.put(HomeController());

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Obx(
              () => MyList.fragmentScreen[_indexNumber.value],
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: _indexNumber.value,
              onTap: _onBottomNavigationTapped,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.grey,
              unselectedItemColor: Colors.grey,
              items: List.generate(
                4,
                (index) {
                  var navButtonProperty =
                      MyList.navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                      icon: Icon(navButtonProperty["non_active_icon"]),
                      activeIcon: Icon(navButtonProperty["active_icon"]),
                      label: navButtonProperty["label"]);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _onBottomNavigationTapped(int index) {
    if (index == 0) {
      // ignore: unused_local_variable
      HomeController homeController = Get.find<HomeController>();
      // homeController.refreshHomeView();
    }
    _indexNumber.value = index;
  }
}
