import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/entity/correspondence_name_record.dart';
import 'package:todo_app/repository/correspondence_name_record_repository.dart';
import 'package:todo_app/repository/name_repository.dart';

class NameModel with ChangeNotifier {
  Record record;
  List<Name> _allNameList;
  List<Name> _recordNameList;
  List<CorrespondenceNameRecord> _allCorrespondenceList;
  List<CorrespondenceNameRecord> _recordCorrespondenceList;
  List<Name> get allNameList => _allNameList;
  List<Name> get recordNameList => _recordNameList;

  final nameRepo = NameRepository();
  final correspondenceRepo = CorrespondenceNameRecordRepository();

  NameModel({this.record}) {
    _fetchAll();
  }

  void getRecordCorrespondenceList(){
    _recordCorrespondenceList =
        _allCorrespondenceList
            .where((correspondence) => correspondence.recordId == record.id)
            .toList();
  }

  void getRecordNameList() {
    final List <Name> list = [];    
    for (final correspondence in _recordCorrespondenceList) {
      for (final name in _allNameList) {
        if (correspondence.nameId == name.id) {
          list.add(name);
        }
      }
    }
    _recordNameList = list;
  }
  
  // レコードに対応する名前を更新するときに使う
  Future updateRecordName(List<TextEditingController> newTextList, List<TextEditingController> oldTextList) async {
    var index = 0;
    for(final text in newTextList){
      if(text.text != oldTextList[index].text){
        for(final name in _allNameList) {
          if (oldTextList[index].text == name.name) {
            name.name = text.text;
            await nameRepo.updateName(name);
          }
        }
      }
      index ++;
    }
    await _fetchAll();
  }

  Future _fetchAll() async {
    _allNameList = await nameRepo.getAllName();
    _allCorrespondenceList = await correspondenceRepo.getAllCorrespondence();
    getRecordCorrespondenceList();
    getRecordNameList();
    notifyListeners();
  }

  // 名前と、レコードと名前の対応をそれぞれDBに記録
  Future setNewName(
      List<TextEditingController> textList) async {
    for (final text in textList) {
      if(text.text.isNotEmpty) {
        final nameId = await nameRepo.insertName(Name(name: text.text));
        await correspondenceRepo.insertCorrespondence(
            CorrespondenceNameRecord(nameId: nameId, recordId: record.id));
      }
    }
    await _fetchAll();
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
    await nameRepo.deleteNameById(name.id);
    _fetchAll();
  }
}
