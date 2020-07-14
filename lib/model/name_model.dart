import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/entity/mapping_name_record.dart';
import 'package:todo_app/repository/mapping_name_record_repository.dart';
import 'package:todo_app/repository/name_repository.dart';

class NameModel with ChangeNotifier {
  Record record;
  List<Name> _allNameList;
  List<Name> _recordNameList;
  bool _isUpdate = true;
  List<MappingNameRecord> _allCorrespondenceList;
  List<MappingNameRecord> _recordCorrespondenceList;
  List<Name> get allNameList => _allNameList;
  List<Name> get recordNameList => _recordNameList;
  bool get isUpdate => _isUpdate;

  final nameRepo = NameRepository();
  final mappingRepo = MappingNameRecordRepository();

  NameModel({this.record}) {
    _fetchAll();
  }

  void getRecordCorrespondenceList() {
    _recordCorrespondenceList = _allCorrespondenceList
        .where((correspondence) => correspondence.recordId == record.recordId)
        .toList();
  }

  void getRecordNameList() {
    final List<Name> list = [];
    for (final correspondence in _recordCorrespondenceList) {
      for (final name in _allNameList) {
        if (correspondence.nameId == name.nameId) {
          list.add(name);
        }
      }
    }
    _recordNameList = list;
  }

  // レコードに対応する名前を更新するときに使う
  // 既に登録されている名前に変更しようとした場合にisUpdateをfalseにする
  Future updateRecordName(List<TextEditingController> newTextList,
      List<TextEditingController> oldTextList) async {
    var index = 0;
    _isUpdate = true;
    for (final text in newTextList) {
      if (text.text != oldTextList[index].text) {
        if (_allNameList
            .map((name) => name.name)
            .toList()
            .contains(text.text)) {
          _isUpdate = false;
          index++;
          break;
        } else {
          for (final name in _allNameList) {
            if (name.name == oldTextList[index].text) {
              name.name = text.text;
              await nameRepo.updateName(name);
              break;
            }
          }
        }
      }
      index++;
    }
    await _fetchAll();
  }

  Future _fetchAll() async {
    _allNameList = await nameRepo.getAllName();
    _allCorrespondenceList = await mappingRepo.getAllMapping();
    getRecordCorrespondenceList();
    getRecordNameList();
    notifyListeners();
  }

  // 名前と、レコードと名前の対応をそれぞれDBに記録
  Future setNewName(List<TextEditingController> textList) async {
    for (final text in textList) {
      if (_allNameList.map((name) => name.name).toList().contains(text.text)) {
        _registeredName(text.text);
      } else if (text.text.isNotEmpty) {
        final nameId = await nameRepo.insertName(Name(name: text.text));
        await mappingRepo.insertMapping(
            MappingNameRecord(nameId: nameId, recordId: record.recordId));
      }
    }
    await _fetchAll();
  }

  /// 既に登録されている名前の場合の処理
  Future _registeredName(String inName) async {
    for (final name in _allNameList) {
      if (inName == name.name) {
        final nameId = name.nameId;
        await mappingRepo.insertMapping(
            MappingNameRecord(nameId: nameId, recordId: record.recordId));
      }
    }
  }

  Future add(Name name) async {
    nameRepo.insertName(name);
    _fetchAll();
  }

  Future update(Name name) async {
    await nameRepo.updateName(name);
    _fetchAll();
  }

  Future remove(Name name) async {
    await nameRepo.deleteNameById(name.nameId);
    _fetchAll();
  }
}
