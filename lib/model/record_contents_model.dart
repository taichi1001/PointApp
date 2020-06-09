import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  List<RecordContents> _allRecordContentsList = [];

  List<RecordContents> get allRecordContentsList => _allRecordContentsList;

  List<RecordContents> recordContentsList(Record record) =>
      _allRecordContentsList
          .where((recordContents) => recordContents.recordId == record.id)
          .toList();

  final RecordContentsRepository repo = RecordContentsRepository();

  RecordContentsModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    _allRecordContentsList = await repo.getAllRecordsContents();
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
