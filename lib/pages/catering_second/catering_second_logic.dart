import 'package:catering_management/db_catering/db_catering.dart';
import 'package:catering_management/pages/catering_second/catering_second_view.dart';
import 'package:get/get.dart';

import '../../db_catering/catering_entity.dart';

class CateringSecondLogic extends GetxController {

  DBCatering dbCatering = Get.find<DBCatering>();

  int type = 0;
  var weekTotal = 0.obs;
  var averageDay = 0.obs;

  List<CateringData> monthData = [];
  var allData = <CateringEntity>[].obs;

  void getMonthData() async {
    final int currentYear = DateTime.now().year;
    final Map<int, int> yearlyMonthlyCalories = await dbCatering.getYearlyMonthlyCalories(currentYear);
    monthData.clear();
    final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    for (var month = 1; month <= 12; month++) {
      monthData.add(CateringData(months[month-1], yearlyMonthlyCalories[month] ?? 0));
    }

    final List<CateringEntity> weekData = await dbCatering.getWeekData();
    final totalCalories = weekData.fold(0, (sum, item) => sum + item.calorie);
    weekTotal.value = totalCalories;
    final Map<String, int> dailyCalories = {};
    for (var item in weekData) {
      final String dateKey = DateTime(item.createdTime.year, item.createdTime.month, item.createdTime.day).toIso8601String();
      dailyCalories[dateKey] = (dailyCalories[dateKey] ?? 0) + item.calorie;
    }
    final double averageDailyCalories =
    dailyCalories.isNotEmpty ? totalCalories / dailyCalories.length : 0;
    averageDay.value = averageDailyCalories.toInt();
    update();
  }

  void getAllData() async {
    allData.value = await dbCatering.getAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getMonthData();
    super.onInit();
  }


}
