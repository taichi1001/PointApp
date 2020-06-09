import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/repository/name_repository.dart';

import '../entity/record_contents.dart';

class NameModel with ChangeNotifier {
  List<Name> _allNameList = [];
  List<Name> get allNameList => _allNameList;

  final repo = NameRepository();

  NameModel() {
    _fetchAll();
  }

  List<String> getRecordNameList(List<RecordContents> recordContentsList){
    final List<String> list =[];
    for(final name in _allNameList) {
      for (final recordContents in recordContentsList) {
        if(name.id == recordContents.nameId){
          list.add(name.name);
        }
      }
    }
    final returnList = list.toSet().toList();
    return returnList;
  }

  Future setNameList(List<TextEditingController> list) async {
    for(final textEditingController in list){
      final name = Name(name: textEditingController.text);
      add(name);
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
