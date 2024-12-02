import 'package:catering_management/main.dart';
import 'package:catering_management/pages/catering_third/catering_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'catering_first_logic.dart';

class CateringFirstPage extends GetView<CateringFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catering management'),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.add_box,
            size: 30,
            color: primaryColor,
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.addData();
          })
        ],
      ),
      body: SafeArea(
          child: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: <Widget>[
            const Text(
              'Calorie of the day',
              style: TextStyle(color: Colors.white),
            ),
            Obx(() {
              return Text(
                '${controller.todayCatering.value}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              );
            }),
            Obx(() {
              return Text(
                'Target: ${controller.targetCalorie.value}',
                style: const TextStyle(color: Colors.white),
              );
            })
          ].toColumn(),
        ).decorated(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: <Widget>[
            const Text('Food intake Today'),
            Expanded(child: Obx(() {
              return controller.list.value.isEmpty
                  ? const Center(
                      child: Text('No data'),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.list.value.length,
                      itemBuilder: (_, index) {
                        final entity = controller.list.value[index];
                        return <Widget>[
                          <Widget>[
                            Icon(
                              Icons.emoji_food_beverage,
                              size: 20,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              entity.name,
                              style: const TextStyle(color: Colors.grey),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${entity.calorie} Calorie',
                              style: TextStyle(color: primaryColor),
                            )
                          ].toRow(),
                          Divider(
                            height: 20,
                            color: Colors.grey[300],
                          )
                        ].toColumn();
                      });
            }))
          ].toColumn(),
        ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12)))
      ].toColumn().marginAll(15)),
    );
  }
}
