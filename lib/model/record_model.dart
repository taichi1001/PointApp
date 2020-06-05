import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/repository/record_repository.dart';

class RecordModel with ChangeNotifier{
  List<Record> _allRecordList = [];
  List<Record> get allRecordContentsList => _allRecordList;
  List<Record> get incompletedTodoList => _allRecordList.where((record) => record.isDone == false).toList();
  List<Record> get completedTodoList => _allRecordList.where((record) => record.isDone == true).toList();

  final RecordRepository repo = RecordRepository();

  RecordModel(){
    _fetchAll();
  }

  void _fetchAll() async {
    _allRecordList = await repo.getAllRecords();
    notifyListeners();
  }

  void add(Record todo) async {
    await repo.insertRecord(todo);
    _fetchAll();
  }

  void update(Record todo) async {
    await repo.updateRecord(todo);
    _fetchAll();
  }

  void toggleIsDone(Record todo) async {
    todo.isDone = !todo.isDone;
    update(todo);
  }

  void remove(Record todo) async {
    await repo.deleteRecordById(todo.id);
    _fetchAll();
  }

}