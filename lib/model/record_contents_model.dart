import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  List<RecordContents> _allRecordContentsList = [];
  List<RecordContents> get allRecordContentsList => _allRecordContentsList;
  List<RecordContents> recordContentsList(Record record) =>
      _allRecordContentsList
          .where((recordContents) => recordContents.recordId == record.id)
          .toList();

  final RecordContentsRepository repo = RecordContentsRepository();
  final NameModel nameModel = NameModel();

  RecordContentsModel() {
    _fetchAll();
  }

  List<DataColumn> getDataColumn(Record record){
    final nameList = nameModel.getRecordNameList(record);
    final List<DataColumn> dataColumn = [];
    for(final name in nameList){
      dataColumn.add(DataColumn(label: Text(name.name)));
    }
    return dataColumn;
  }
//  これから実装
//  入力されたレコードに対応するコンテンツを全て配列に取得
//  配列からrecordContents.countの数が同じものどうしを<DataCell>配列にかためて、
//  それをcountの順番に<DataRow>配列に入れる

//  List<DataRow> getDataRow(Record record){
//    final List<DataRow> dataRow = [];
//    for(final dataCell in _getDataCell(record)){
//      dataRow.add(DataRow(cells: dataCell));
//    }
//  }
//
//  List<DataCell> _getDataCell(Record record){
//    final nameList = nameModel.getRecordNameList(record);
//    final List<DataCell> dataCell = [];
//    for(final recordContents in _allRecordContentsList){
//      for(final name in nameList){
//        if(recordContents.nameId == name.id && recordContents.recordId == record.id){
//
//        }
//      }
//    }
//    for(final name in nameList){
//      dataCell.add(DataCell(Text(name.name)));
//    }
//    return dataCell;
//  }

  Future _fetchAll() async {
    _allRecordContentsList = await repo.getAllRecordsContents();
    notifyListeners();
  }

  Future add(RecordContents recordContents) async {
    await repo.insertRecordContents(recordContents);
    _fetchAll();
  }

  Future update(RecordContents recordContents) async {
    await repo.updateRecordContents(recordContents);
    _fetchAll();
  }

  Future remove(RecordContents recordContents) async {
    await repo.deleteRecordContentsById(recordContents.id);
    _fetchAll();
  }
}
