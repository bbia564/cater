
import 'package:catering_management/db_catering/catering_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class DBCatering extends GetxService {
  late Database dbBase;

  Future<DBCatering> init() async {
    await createCateringDB();
    return this;
  }

  createCateringDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'catering.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createCateringTable(db);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('calorie', 630);
        });
  }

  createCateringTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS catering (id INTEGER PRIMARY KEY, createdTime TEXT, name TEXT, calorie INTEGER)');
  }

  insertCatering(CateringEntity entity) async {
    final id = await dbBase.insert('catering', {
      'createdTime': entity.createdTime.toIso8601String(),
      'name': entity.name,
      'calorie': entity.calorie,
    });
    return id;
  }

  cleanCateringData() async {
    await dbBase.delete('catering');
  }

  Future<List<CateringEntity>> getTodayData() async {
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);
    final DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    final List<Map<String, dynamic>> maps = await dbBase.query(
      'catering',
      where: 'createdTime >= ? AND createdTime < ?',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return CateringEntity.fromJson(maps[i]);
    });
  }

  Future<List<CateringEntity>> getWeekData() async {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final DateTime startOfDay = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    final DateTime endOfWeek = startOfDay.add(const Duration(days: 7));

    final List<Map<String, dynamic>> maps = await dbBase.query(
      'catering',
      where: 'createdTime >= ? AND createdTime < ?',
      whereArgs: [startOfDay.toIso8601String(), endOfWeek.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return CateringEntity.fromJson(maps[i]);
    });
  }

  Future<List<CateringEntity>> getAllData() async {
    final List<Map<String, dynamic>> maps = await dbBase.query('catering');
    return List.generate(maps.length, (i) {
      return CateringEntity.fromJson(maps[i]);
    });
  }

  Future<Map<int, int>> getYearlyMonthlyCalories(int year) async {
    final List<CateringEntity> allData = await getAllData();
    final Map<int, int> monthlyCalories = {
      for (int month = 1; month <= 12; month++) month: 0,
    };
    for (var item in allData) {
      if (item.createdTime.year == year) {
        final int month = item.createdTime.month;
        monthlyCalories[month] = monthlyCalories[month]! + item.calorie;
      }
    }

    return monthlyCalories;
  }
}
