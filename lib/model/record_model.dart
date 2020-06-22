import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  List<Record> _allRecordList = [];
  List<Record> get allRecordList => _allRecordList;
  List<Record> get incompletedTodoList =>
      _allRecordList.where((record) => record.isDone == false).toList();
  List<Record> get completedTodoList =>
      _allRecordList.where((record) => record.isDone == true).toList();

  final RecordRepository repo = RecordRepository();

  RecordModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    _allRecordList = await repo.getAllRecords();
    notifyListeners();
  }

  Future add(Record record) async {
    await repo.insertRecord(record);
    _fetchAll();
  }

  Future update(Record record) async {
    await repo.updateRecord(record);
    _fetchAll();
  }

  Future toggleIsDone(Record record) async {
    record.isDone = !record.isDone;
    update(record);
  }

  Future changeNumberPeople(Record record, int newCount) async {
    record.numberPeople = newCount;
    update(record);
  }

  Future remove(Record record) async {
    await repo.deleteRecordById(record.id);
    _fetchAll();
  }
}
