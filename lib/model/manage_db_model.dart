import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/entity/mapping_name_record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/repository/mapping_name_record_repository.dart';
import 'package:todo_app/repository/name_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';
import 'package:todo_app/repository/record_repository.dart';

class ManageDBModel with ChangeNotifier {
  List<Record> allRecordList = [];
  List<RecordContents> allRecordContentsList = [];
  List<Name> allNameList = [];
  List<MappingNameRecord> allCorrespondenceList = [];

  final nameRepo = NameRepository();
  final correspondenceRepo = MappingNameRecordRepository();
  final recordRepo = RecordRepository();
  final recordContentsRepo = RecordContentsRepository();

  ManageDBModel() {
    fetchAll();
  }

  Future fetchAll() async {
    allRecordList = await recordRepo.getAllRecords();
    allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    allNameList = await nameRepo.getAllName();
    allCorrespondenceList = await correspondenceRepo.getAllMapping();
    notifyListeners();
  }
}
