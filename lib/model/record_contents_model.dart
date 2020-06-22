import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  final Record record;
  NameModel nameModel;

  List<RecordContents> _allRecordContentsList = [];
  List<RecordContents> _recordContentsList = [];
  List<List<RecordContents>> _recordContentsPerCount = [];
  int _count = 0;

  List<RecordContents> get allRecordContentsList => _allRecordContentsList;
  List<RecordContents> get recordContentsList => _recordContentsList;
  List<List<RecordContents>> get recordContentsPerCount =>
      _recordContentsPerCount;

  final RecordContentsRepository repo = RecordContentsRepository();

  RecordContentsModel({this.record}) {
    nameModel = NameModel(record: record);
    _fetchAll();
  }

  void addCount(){
    _count ++;
}

  Future addNewRecordContents(
      List<TextEditingController> textList, List<Name> nameList) async {
    var index = 0;
    for (final text in textList) {
      await repo.insertRecordContents(RecordContents(
          recordId: record.id,
          nameId: nameList[index].id,
          count: _count,
          score: int.parse(text.text)));
      index += 1;
    }
    await _fetchAll();
  }

  void _getRecordContentsPerCount() {
    final List<List<RecordContents>> __recordContentsPerCount = [];

    for(int count = 1; count <= _count; count++){
      final List<RecordContents> perCount = [];
      for (final recordContents in _recordContentsList) {
        if (recordContents.count == count) {
          perCount.add(recordContents);
        }
      }
        __recordContentsPerCount.add(perCount);
    }
    _recordContentsPerCount = __recordContentsPerCount;
  }

  void _getRecordContentsList() {
    final List<RecordContents> tmp = _allRecordContentsList
        .where((recordContents) => recordContents.recordId == record.id)
        .toList();

    _recordContentsList = tmp;
  }

  void _getCount(){
    int maxCount = 0;
    if (_recordContentsList.isNotEmpty) {
      maxCount = _recordContentsList.map((
          recordContents) => recordContents.count).toList().reduce(max);

     }
     _count = maxCount;
    
  }

  Future _fetchAll() async {
    _allRecordContentsList = await repo.getAllRecordsContents();
    _getRecordContentsList();
    _getCount();
    _getRecordContentsPerCount();
    notifyListeners();

  }

  Future add(RecordContents recordContents) async {
    await repo.insertRecordContents(recordContents);
    _fetchAll();
  }

  Future update(RecordContents recordContents) async {
    await repo.updateRecordContents(recordContents);
    _fetchAll();
  }

  Future remove(RecordContents recordContents) async {
    await repo.deleteRecordContentsById(recordContents.id);
    _fetchAll();
  }
}
