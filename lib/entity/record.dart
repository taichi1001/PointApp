import 'package:flutter/material.dart';

class Record with ChangeNotifier {
  int recordId;
  DateTime date;
  String title;
  int numberPeople;
  bool isEdit;

  Record({this.recordId, this.date, this.title, this.numberPeople = 1, this.isEdit = false});

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
        recordId: data['record_id'],
        date: DateTime.parse(data['date']).toLocal(),
        title: data['title'],
        numberPeople: data['number_people'],
        isEdit: data['is_edit'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'record_id': recordId,
        'date': date.toUtc().toIso8601String(),
        'title': title,
        'number_people': numberPeople,
        'is_edit': isEdit ? 1 : 0,
      };

  Future changeNumberPeople(int newCount) async {
    numberPeople = newCount;
    notifyListeners();
  }

  Future changeIsEdit() async {
    isEdit = !isEdit;
    notifyListeners();
  }

}
