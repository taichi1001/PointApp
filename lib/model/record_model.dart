import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/tag_model.dart';
import 'package:todo_app/repository/correspondence_name_record_repository.dart';
import 'package:todo_app/repository/rank_rate_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';
import 'package:todo_app/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  int _selectedTagId = 0;
  String _selectedTag;
  List<Record> _allRecordList = [];
  List<Record> _toDisplayRecord = [];
  String get selectedTag => _selectedTag;
  List<Record> get allRecordList => _allRecordList;
  List<Record> get toDisplayRecord => _toDisplayRecord;

  final RecordRepository recordRepo = RecordRepository();
  final RecordContentsRepository recordContentsRepo =
      RecordContentsRepository();
  final CorrespondenceNameRecordRepository correspondenceRepo =
      CorrespondenceNameRecordRepository();
  final RankRateRepository rankRateRepo = RankRateRepository();

  RecordModel() {
    _fetchAll();
  }

  void changeSelectedTag(String newTag, TagModel tagModel) {
    for(final tag in tagModel.allTagList){
      if(tag.tag == newTag){
        _selectedTagId = tag.tagId;
        _selectedTag = tag.tag;
      }
    }
    _fetchAll();
  }

  void _selectToRecordDisplay() {
    if (_selectedTagId == 0) {
      _toDisplayRecord = _allRecordList;
    } else {
      _toDisplayRecord = _allRecordList
          .where((record) => record.tagId == _selectedTagId)
          .toList();
    }
    notifyListeners();
  }

  Future _fetchAll() async {
    _allRecordList = await recordRepo.getAllRecords();
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
    await correspondenceRepo.deleteCorrespondenceByRecordId(record.recordId);
    _fetchAll();
  }
}
