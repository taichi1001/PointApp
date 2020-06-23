import 'package:flutter/material.dart';

class Record with ChangeNotifier {
  int id;
  DateTime date;
  String title;
  int numberPeople;
  bool isDone;

  Record({this.id, this.date, this.title, this.numberPeople = 1, this.isDone = false});

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
        id: data['id'],
        date: DateTime.parse(data['date']).toLocal(),
        title: data['title'],
        numberPeople: data['number_people'],
        isDone: data['is_done'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': id,
        'date': date.toUtc().toIso8601String(),
        'title': title,
        'number_people': numberPeople,
        'is_done': isDone ? 1 : 0,
      };

  Future changeNumberPeople(int newCount) async {
    numberPeople = newCount;
    notifyListeners();

  }
}
