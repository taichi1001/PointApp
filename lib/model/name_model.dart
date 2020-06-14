import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/entity/correspondence_name_record.dart';
import 'package:todo_app/repository/correspondence_name_record_repository.dart';
import 'package:todo_app/repository/name_repository.dart';

class NameModel with ChangeNotifier {
  List<Name> _allNameList = [];
  List<CorrespondenceNameRecord> _allCorrespondenceList = [];
  List<Name> get allNameList => _allNameList;

  final nameRepo = NameRepository();
  final correspondenceRepo = CorrespondenceNameRecordRepository();

  NameModel() {
    _fetchAll();
  }

  // レコードに対応する名前のリストを取得
  List<Name> getRecordNameList(Record record) {
    final List<Name> nameList = [];
    final List<CorrespondenceNameRecord> correspondenceList =
        _allCorrespondenceList
            .where((correspondence) => correspondence.recordId == record.id)
            .toList();
    for (final correspondence in correspondenceList) {
      for (final name in _allNameList) {
        if (correspondence.nameId == name.id) {
          nameList.add(name);
        }
      }
    }
    return nameList;
  }

  Future _fetchAll() async {
    _allNameList = await nameRepo.getAllName();
    _allCorrespondenceList = await correspondenceRepo.getAllCorrespondence();
    notifyListeners();
  }

  // 名前と、レコードと名前の対応をそれぞれDBに記録
  void setNameList(
      List<TextEditingController> textList, Record record) {
    for (final text in textList) {
      add(Name(name: text.text));
      print(_allNameList);
      _setCorrespondenceNameRecord(text, record);
    }
  }

  // レコードと名前の対応をDBに記録
  void _setCorrespondenceNameRecord(
      TextEditingController text, Record record) {
    for (final names in _allNameList) {
      _fetchAll();
      print('start');
      print(names.name);
      if (names.name == text.text) {
        print(names.name);
        print('end');
        setCorrespondence(
            CorrespondenceNameRecord(nameId: names.id, recordId: record.id));
      }
    }
  }

  Future setCorrespondence(CorrespondenceNameRecord correspondence) async {
    await correspondenceRepo.insertCorrespondence(correspondence);
    _fetchAll();
  }

  void add(Name name) {
    nameRepo.insertName(name);
    _fetchAll();
  }

  Future update(Name name) async {
    await nameRepo.updateName(name);
    _fetchAll();
  }

  Future remove(Name name) async {
    await nameRepo.deleteNameById(name.id);
    _fetchAll();
  }
}
