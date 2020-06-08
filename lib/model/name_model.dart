import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/repository/name_repository.dart';

import '../entity/record_contents.dart';

class NameModel with ChangeNotifier {
  List<RecordContents> _allNameList = [];
  List<RecordContents> get allNameList => _allNameList;

// 実装中
  // List<RecordContents> nameList(List<RecordContents> recordcontentsList) =>
  //     _allNameList
  //         .where((recordContents) => recordContents.recordId == recordcontentsList.nameId)
  //         .toList();
// 

  final NameRepository repo = NameRepository();

  NameModel() {
    _fetchAll();
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
