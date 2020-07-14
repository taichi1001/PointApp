import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/entity/correspondence_name_record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/repository/correspondence_name_record_repository.dart';
import 'package:todo_app/repository/name_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';
import 'package:todo_app/repository/record_repository.dart';

class ManageDBModel with ChangeNotifier {
  List<Record> _allRecordList = [];
  List<RecordContents> _allRecordContentsList = [];
  List<Name> _allNameList = [];
  List<MappingNameRecord> _allCorrespondenceList = [];
  List<Record> get allRecordList => _allRecordList;
  List<RecordContents> get allRecordContentsList => _allRecordContentsList;
  List<Name> get allNameList => _allNameList;
  List<MappingNameRecord> get allCorrespondenceList => _allCorrespondenceList;

  final nameRepo = NameRepository();
  final correspondenceRepo = MappingNameRecordRepository();
  final recordRepo = RecordRepository();
  final recordContentsRepo = RecordContentsRepository();

  ManageDBModel() {
    fetchAll();
  }

  Future fetchAll() async {
    _allRecordList = await recordRepo.getAllRecords();
    _allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    _allNameList = await nameRepo.getAllName();
    _allCorrespondenceList = await correspondenceRepo.getAllMapping();
    notifyListeners();
  }
}
