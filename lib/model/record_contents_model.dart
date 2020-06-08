import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier{
  List<RecordContents> _allRecordContentsList = [];
  List<String> _rangePeople = ['1', '2', '3','4'];
  String _rangeValue = '1';

  List<RecordContents> get allRecordContentsList => _allRecordContentsList;
  List<String> get rangePeople => _rangePeople;
  String get rangeValue => _rangeValue;
  List<RecordContents> recordContentsList(Record record)=> _allRecordContentsList.where((recordContents) => recordContents.recordId == record.id).toList();

  void setRangeValue(String value){
    _rangeValue = value;
    notifyListeners();
  }

  final RecordContentsRepository repo = RecordContentsRepository();

  RecordContentsModel(){
    _fetchAll();
  }

  void _fetchAll() async {
    _allRecordContentsList = await repo.getAllRecordsContents();
    notifyListeners();
  }

  void add(RecordContents recordContents) async {
    await repo.insertRecordContents(recordContents);
    _fetchAll();
  }

  void update(RecordContents recordContents) async {
    await repo.updateRecordContents(recordContents);
    _fetchAll();
  }

  void remove(RecordContents recordContents) async {
    await repo.deleteRecordContentsById(recordContents.id);
    _fetchAll();
  }

}