import 'package:intl/intl.dart';

class CateringEntity {
  int id;
  DateTime createdTime;
  String name;
  int calorie;

  CateringEntity({
    required this.id,
    required this.createdTime,
    required this.name,
    required this.calorie,
  });

  factory CateringEntity.fromJson(Map<String, dynamic> json) {
    return CateringEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      name: json['name'],
      calorie: json['calorie'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'name': name,
      'calorie': calorie,
    };
  }

  String get createdTimeString {
    return DateFormat('yyyy-MM-dd').format(createdTime);
  }
}