import 'package:flutter/material.dart';

class Record with ChangeNotifier {
  int recordId;
  DateTime date;
  String title;
  int numberPeople;
  String mode;
  bool isEdit;
  bool isDuplicate;

  Record({this.recordId, this.date, this.title, this.numberPeople = 1, this.mode = '順位モード', this.isEdit = false, this.isDuplicate = false});

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
        recordId: data['record_id'],
        date: DateTime.parse(data['date']).toLocal(),
        title: data['title'],
        numberPeople: data['number_people'],
        mode: data['mode'],
        isEdit: data['is_edit'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'record_id': recordId,
        'date': date.toUtc().toIso8601String(),
        'title': title,
        'number_people': numberPeople,
        'mode': mode,
        'is_edit': isEdit ? 1 : 0,
      };

  Future changeNumberPeople(int newCount) async {
    numberPeople = newCount;
    notifyListeners();
  }

  Future changeMode(String newMode) async{
    mode = newMode;
    notifyListeners();    
  }

  Future changeIsEdit() async {
    isEdit = !isEdit;
    notifyListeners();
  }

}
