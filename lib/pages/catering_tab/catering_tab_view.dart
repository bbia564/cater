import 'package:catering_management/pages/catering_first/catering_first_logic.dart';
import 'package:catering_management/pages/catering_first/catering_first_view.dart';
import 'package:catering_management/pages/catering_second/catering_second_view.dart';
import 'package:catering_management/pages/catering_third/catering_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../catering_second/catering_second_logic.dart';
import 'catering_tab_logic.dart';

class CateringTabPage extends GetView<CateringTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          CateringFirstPage(),
          CateringSecondPage(),
          CateringThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navEnBars()),
    );
  }

  Widget _navEnBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/item0Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/item0Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item1Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/item1Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item2Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/item2Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Set',
        )
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index ==0) {
          CateringFirstLogic firstLogic = Get.find<CateringFirstLogic>();
          firstLogic.getData();
        } else if (index ==1) {
          CateringSecondLogic secondLogic = Get.find<CateringSecondLogic>();
          secondLogic.getMonthData();
        }
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
      },
    );
  }
}
