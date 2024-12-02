import 'package:catering_management/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'catering_second_logic.dart';

class CateringSecondPage extends GetView<CateringSecondLogic> {
  Widget _topItem(int index) {
    final titles = ['Statistics', 'Details'];
    return Expanded(
        child: Container(
      height: 60,
      alignment: Alignment.center,
      child: Text(
        titles[index],
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: controller.type == index ? Colors.black : Colors.grey),
      ),
    )
            .decorated(
                borderRadius: BorderRadius.circular(12),
                border: controller.type == index
                    ? Border.all(color: primaryColor)
                    : null,
                color: controller.type == index
                    ? const Color(0xffffe9d0)
                    : Colors.white)
            .gestures(onTap: () {
      controller.type = index;
      if (index == 0) {
        controller.getMonthData();
      } else {
        controller.getAllData();
      }
      controller.update();
    }));
  }

  Widget _content() {
    if (controller.type == 0) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: <Widget>[
              const Text('Calorie intake trend'),
              Container(
                  child: controller.monthData.isEmpty
                      ? const Center(
                          child: Text('No data'),
                        )
                      : SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <LineSeries<CateringData, String>>[
                              LineSeries<CateringData, String>(
                                  dataSource: controller.monthData,
                                  xValueMapper: (CateringData sales, _) =>
                                      sales.month,
                                  yValueMapper: (CateringData sales, _) =>
                                      sales.catering)
                            ]))
            ].toColumn(),
          ).decorated(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: <Widget>[
              const Text('Calorie intake this week'),
              Divider(
                height: 25,
                color: Colors.grey[300],
              ),
              <Widget>[
                <Widget>[
                  const Text(
                    'Total intake',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('${controller.weekTotal.value} Calorie',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold))
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                const SizedBox(
                  width: 10,
                ),
                <Widget>[
                  const Text(
                    'Average day',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${controller.averageDay.value} Calorie',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            ].toColumn(),
          ).decorated(
              color: Colors.white, borderRadius: BorderRadius.circular(12))
        ].toColumn(),
      );
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Obx(() {
        return controller.allData.value.isEmpty
            ? const Center(
                child: Text('No data'),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.allData.value.length,
                itemBuilder: (_, index) {
                  final entity = controller.allData.value[index];
                  return <Widget>[
                    <Widget>[
                      Text(
                        entity.createdTimeString,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Expanded(
                          child: Text(
                        '${entity.calorie} Calorie',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ))
                    ].toRow(),
                    Divider(
                      height: 20,
                      color: Colors.grey[300],
                    )
                  ].toColumn();
                });
      }),
    ).decorated(color: Colors.white, borderRadius: BorderRadius.circular(12));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historical track"),
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<CateringSecondLogic>(
          init: CateringSecondLogic(),
          builder: (_) {
            return SafeArea(
                child: <Widget>[
              <Widget>[
                _topItem(0),
                const SizedBox(
                  width: 10,
                ),
                _topItem(1)
              ].toRow(),
              const SizedBox(
                height: 15,
              ),
              Expanded(child: _content())
            ].toColumn().marginAll(15));
          }),
    );
  }
}

class CateringData {
  CateringData(this.month, this.catering);

  final String month;
  final int catering;
}
