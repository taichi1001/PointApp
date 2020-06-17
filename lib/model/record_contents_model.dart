import 'dart:math';
import 'package:quiver/iterables.dart' as quiver;
import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  List<RecordContents> _allRecordContentsList = [];
  List<RecordContents> get allRecordContentsList => _allRecordContentsList;

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

//  入力されたレコードに対応するコンテンツを全て配列に取得
//  配列からrecordContents.countの数が同じものどうしを<DataCell>配列にかためて、
//  それをcountの順番に<DataRow>配列に入れる
  List<RecordContents> getRecordContentsList(Record record) =>
      _allRecordContentsList
          .where((recordContents) => recordContents.recordId == record.id)
          .toList();

  List<DataRow> getDataRow(Record record){
    final recordContentsList = getRecordContentsList(record);
    final List<int> countRange = _getRecordCountRangeList(recordContentsList);
    final List<DataRow> dataRow = [];
    for(final count in countRange){
      dataRow.add(DataRow(cells:_getDataCell(count, recordContentsList)));
    }
    return dataRow;
  }

  List<int> _getRecordCountRangeList(List<RecordContents> recordContentsList) {
    final List<int> recordCountList = [];
    recordContentsList.map((recordContents) => recordCountList.add(recordContents.count)).toList();
    final int maxCount = recordCountList.reduce(max);
    final List<int> countRange = quiver.range(1, maxCount);
    return countRange;
  }

  List<DataCell> _getDataCell(int count, List<RecordContents> recordContentsList){
    final List<DataCell> dataCellList = [];
    for(final recordContents in recordContentsList){
      if(count == recordContents.count){
        dataCellList.add(DataCell(Text(recordContents.score.toString())));
      }
    }
    return dataCellList; 
  }

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
