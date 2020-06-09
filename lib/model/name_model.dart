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

  List<Name> getRecordNameList(List<RecordContents> recordContentsList){
    final list =[];
    for(final name in _allNameList){
      for(final recordContents in recordContentsList){
        if(name.id == recordContents.nameId){
          list.add(name.name);
        }
      }
    }
    final nameList = list.toSet().toList();
    return nameList;
  }  

  Future setNameList(List<TextEditingController> list) async {
    for(final name in list){
      final nameInstance = Name(name: name.text);
      add(nameInstance);
    }
  }

  Future _fetchAll() async {
    _allNameList = await repo.getAllName();
    notifyListeners();
  }

  Future add(Name name) async {
    await repo.insertName(name);
    _fetchAll();
  }

  Future update(Name name) async {
    await repo.updateName(name);
    _fetchAll();
  }

  Future remove(Name name) async {
    await repo.deleteNameById(name.id);
    _fetchAll();
  }
}
