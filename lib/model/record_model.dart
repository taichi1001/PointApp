import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/repository/correspondence_name_record_repository.dart';
import 'package:todo_app/repository/rank_rate_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';
import 'package:todo_app/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  List<Record> _allRecordList = [];
  List<Record> get allRecordList => _allRecordList;
  List<Record> get incompletedTodoList =>
      _allRecordList.where((record) => record.isEdit == false).toList();
  List<Record> get completedTodoList =>
      _allRecordList.where((record) => record.isEdit == true).toList();

  final RecordRepository recordRepo = RecordRepository();
  final RecordContentsRepository recordContentsRepo = RecordContentsRepository();
  final CorrespondenceNameRecordRepository coresspondenceRepo = CorrespondenceNameRecordRepository();
  final RankRateRepository rankRateRepo = RankRateRepository();

  RecordModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    _allRecordList = await recordRepo.getAllRecords();
    notifyListeners();
  }

  Future add(Record record) async {
    await recordRepo.insertRecord(record);
    _fetchAll();
  }

  Future update(Record record) async {
    await recordRepo.updateRecord(record);
    _fetchAll();
  }

  Future toggleIsDone(Record record) async {
    record.isEdit = !record.isEdit;
    update(record);
  }

  Future changeNumberPeople(Record record, int newCount) async {
    record.numberPeople = newCount;
    update(record);
  }

  Future remove(Record record) async {
    await recordRepo.deleteRecordById(record.recordId);
    _fetchAll();
  }

  Future removRelatedData(Record record) async {
    await recordRepo.deleteRecordById(record.recordId);
    await recordContentsRepo.deleteRecordContentsByRecordId(record.recordId);
    await rankRateRepo.deleteRankRateByRecordId(record.recordId);
    await coresspondenceRepo.deleteCorrespondenceByRecordId(record.recordId);
    _fetchAll();
  }
}
