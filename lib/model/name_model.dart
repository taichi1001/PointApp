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
    final List<CorrespondenceNameRecord> correspondanceList =
        _allCorrespondenceList
            .where((correspondence) => correspondence.recordId == record.id)
            .toList();
    for (final correspondance in correspondanceList) {
      for (final name in _allNameList) {
        if (correspondance.nameId == name.id) {
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
  Future setNameList(
      List<TextEditingController> textList, Record record) async {
    for (final text in textList) {
      await add(Name(name: text.text));
      _setCorrespondenceNameRecord(text, record);
    }
  }

  // レコードと名前の対応をDBに記録
  Future _setCorrespondenceNameRecord(
      TextEditingController text, Record record) async {
    for (final names in _allNameList) {
      if (names.name == text.text) {
        await setCorrespondence(
            CorrespondenceNameRecord(nameId: names.id, recordId: record.id));
      }
    }
  }

  Future setCorrespondence(CorrespondenceNameRecord correspondence) async {
    await correspondenceRepo.insertCorrespondence(correspondence);
    _fetchAll();
  }

  Future add(Name name) async {
    await nameRepo.insertName(name);
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
