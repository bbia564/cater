import 'package:catering_management/db_catering/catering_entity.dart';
import 'package:catering_management/db_catering/db_catering.dart';
import 'package:catering_management/pages/catering_first/catering_first_view.dart';
import 'package:catering_management/pages/catering_third/catering_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

class CateringFirstLogic extends GetxController {
  DBCatering dbCatering = Get.find<DBCatering>();

  var list = <CateringEntity>[].obs;

  var todayCatering = 0.obs;
  var targetCalorie = 0.obs;

  void getData() async {
    list.value = await dbCatering.getTodayData();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    targetCalorie.value = prefs.getInt('calorie') ?? 0;
    todayCatering.value = list.fold(0, (previousValue, element) => previousValue + element.calorie);
  }

  addData() async {
    String name = '';
    int calorie = 0;
    Get.dialog(AlertDialog(
      title: const Text(
        'Add food',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        height: 150,
        child: <Widget>[
          const Text('Food name'),
          Container(
            width: double.infinity,
            height: 44,
            child: CateringTextField(
                maxLength: 12,
                value: name,
                onChange: (value) {
                  name = value;
                }),
          ).decorated(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text('Calorie'),
          Container(
            width: double.infinity,
            height: 44,
            child: CateringTextField(
                maxLength: 8,
                isInteger: true,
                value: calorie <= 0 ? '' : calorie.toString(),
                onChange: (value) {
                  if (value.isEmpty) {
                    calorie = 0;
                  } else {
                    calorie = int.parse(value);
                  }
                }),
          ).decorated(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          )
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (name.isEmpty) {
              Fluttertoast.showToast(msg: 'Food name cannot be empty');
              return;
            }
            if (calorie <= 0) {
              Fluttertoast.showToast(msg: 'Calorie cannot be empty');
              return;
            }
            await dbCatering.insertCatering(CateringEntity(
                id: 0,
                name: name,
                calorie: calorie,
                createdTime: DateTime.now()));
            getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
