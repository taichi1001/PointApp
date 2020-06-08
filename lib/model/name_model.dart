import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/repository/name_repository.dart';

import '../entity/record_contents.dart';

class NameModel with ChangeNotifier {
  List<Name> _allNameList = [];
  List<Name> get allNameList => _allNameList;

  final NameRepository repo = NameRepository();

  NameModel() {
    _fetchAll();
  }

//  遅そうなので改善案模索中
//  ここ直す
  List<Name> getRecordNameList(List<RecordContents> recordContentsList){
    List<Name> list =[];
    _allNameList.forEach((Name name) {
      recordContentsList.forEach((RecordContents recordContents) {
        if(name.id == recordContents.nameId){
          list.add(name);
        }
      });
    });
    var returnList = list.toSet().toList();
    return returnList;
  }

  void setNameList(List<TextEditingController> list) async {
    list.forEach((name) {
      var nameInstance = Name(name: name.text);
      add(nameInstance);
    });
  }

  void _fetchAll() async {
    _allNameList = await repo.getAllName();
    notifyListeners();
  }

  void add(Name name) async {
    await repo.insertName(name);
    _fetchAll();
  }

  void update(Name name) async {
    await repo.updateName(name);
    _fetchAll();
  }

  void remove(Name name) async {
    await repo.deleteNameById(name.id);
    _fetchAll();
  }
}
