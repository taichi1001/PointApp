import 'dart:math';
import 'package:quiver/iterables.dart' as quiver;
import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  Record record;
  List<RecordContents> _allRecordContentsList = [];
  List<RecordContents> _recordContentsList = [];
  List<List<RecordContents>> _recordContentsPerCount = [];
  List<int> _countRange = [];
  int _count = 0;

  List<RecordContents> get allRecordContentsList => _allRecordContentsList;
  List<RecordContents> get recordContentsList => _recordContentsList;
  List<List<RecordContents>> get recordContentsPerCount =>
      _recordContentsPerCount;

  final RecordContentsRepository repo = RecordContentsRepository();
  final NameModel nameModel = NameModel();

  RecordContentsModel({this.record}) {
    _fetchAll();
  }

  void addCount() {
    _count += 1;
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

    for (final count in _countRange) {
      final List<RecordContents> perCount = [];
      for (final recordContetns in _recordContentsList) {
        if (recordContetns.count == count) {
          perCount.add(recordContetns);
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

  void _getRecordCountRange() {
    final List<int> recordCountList = [];
    _recordContentsList
        .map((recordContents) => recordCountList.add(recordContents.count))
        .toList();
    final int maxCount = recordCountList.reduce(max);
    final List<int> countRange = quiver.range(1, maxCount);

    _countRange = countRange;
  }

  Future _fetchAll() async {
    _allRecordContentsList = await repo.getAllRecordsContents();
    _getRecordContentsList();
    _getRecordContentsPerCount();
    _getRecordCountRange();
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
