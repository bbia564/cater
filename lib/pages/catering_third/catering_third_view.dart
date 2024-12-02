import 'package:catering_management/main.dart';
import 'package:catering_management/pages/catering_third/catering_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'catering_third_logic.dart';

class CateringThirdPage extends GetView<CateringThirdLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Clean all records', 'Version'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 0 ? const Icon(
          Icons.keyboard_arrow_right,
          size: 20,
          color: Colors.grey,
        ) : const Text('1.0.0').paddingOnly(right: 8)
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          controller.cleanCateringData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set"),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    const Align(
                      alignment: Alignment.center,
                      child: Text('Daily goal'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Calorie'),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<CateringThirdLogic>(init: CateringThirdLogic(),builder: (_) {
                      return Container(
                        width: double.infinity,
                        height: 44,
                        child: CateringTextField(
                            value: controller.calorie == 0
                                ? ''
                                : controller.calorie.toString(),
                            maxLength: 8,
                            isInteger: true,
                            onChange: (value) {
                              if (value.isEmpty) {
                                controller.calorie = 0;
                              } else {
                                controller.calorie = int.parse(value);
                              }
                            }),
                      );
                    }).decorated(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12)),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text('Commit', style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),),
                    ).decorated(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12)).gestures(
                        onTap: () async {
                          if (controller.calorie <= 0) {
                            Fluttertoast.showToast(
                                msg: 'Please fill in the correct calories');
                            return;
                          }
                          final SharedPreferences prefs = await SharedPreferences
                              .getInstance();
                          await prefs.setInt('calorie', controller.calorie);
                          Fluttertoast.showToast(msg: 'Success');
                        })
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    _item(0, context),
                    _item(1, context),
                  ].toColumn(
                      separator: Divider(
                        height: 15,
                        color: Colors.grey.withOpacity(0.3),
                      )),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12))
              ].toColumn(),
            ).marginAll(15)),
      ),
    );
  }
}
