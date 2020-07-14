import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/tag_model.dart';
import 'package:todo_app/repository/mapping_name_record_repository.dart';
import 'package:todo_app/repository/rank_rate_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';
import 'package:todo_app/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  int selectedTagId = 0;
  String selectedTag;
  List<Record> allRecordList = [];
  List<Record> toDisplayRecord = [];

  final RecordRepo recordRepo = RecordRepo();
  final RecordContentsRepo recordContentsRepo = RecordContentsRepo();
  final MappingNameRecordRepo mappingRepo = MappingNameRecordRepo();
  final RankRateRepo rankRateRepo = RankRateRepo();

  RecordModel() {
    _fetchAll();
  }

  void changeSelectedTag(String newTag, TagModel tagModel) {
    for (final tag in tagModel.allTagList) {
      if (tag.tag == newTag) {
        selectedTagId = tag.tagId;
        selectedTag = tag.tag;
      }
    }
    _fetchAll();
  }

  void _selectToRecordDisplay() {
    if (selectedTagId == 0) {
      toDisplayRecord = allRecordList;
    } else {
      toDisplayRecord = allRecordList
          .where((record) => record.tagId == selectedTagId)
          .toList();
    }
    notifyListeners();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAllRecords();
    _selectToRecordDisplay();
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

  Future remove(Record record) async {
    await recordRepo.deleteRecordById(record.recordId);
    _fetchAll();
  }

  Future removeRelatedData(Record record) async {
    await recordRepo.deleteRecordById(record.recordId);
    await recordContentsRepo.deleteRecordContentsByRecordId(record.recordId);
    await rankRateRepo.deleteRankRateByRecordId(record.recordId);
    await mappingRepo.deleteMappingByRecordId(record.recordId);
    _fetchAll();
  }
}
