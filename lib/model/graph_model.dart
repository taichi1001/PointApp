import 'package:flutter/material.dart';
import 'package:todo_app/entity/mapping_name_record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/tag.dart';
import 'package:todo_app/repository/mapping_name_record_repository.dart';
import 'package:todo_app/repository/name_repository.dart';
import 'package:todo_app/repository/rank_rate_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';
import 'package:todo_app/repository/record_repository.dart';
import 'package:todo_app/repository/tag_repository.dart';

class GraphModel with ChangeNotifier {
  List<Record> allRecordList;
  List<Record> tagRecordList;
  List<Tag> allTagList;
  List<Name> allNameList;
  List<Name> tagNameList;
  List<MappingNameRecord> allMappingList;
  List<MappingNameRecord> tagMappingList;
  List<RecordContents> allRecordContentsList;
  List<RecordContents> tagRecordContentsList;
  Map<String, List<int>> scoreMap;
  Map<String, int> nameCheckMap;

  final RecordRepo recordRepo = RecordRepo();
  final MappingNameRecordRepo mappingRepo = MappingNameRecordRepo();
  final TagRepo tagRepo = TagRepo();
  final NameRepo nameRepo = NameRepo();
  final RecordContentsRepo recordContentsRepo = RecordContentsRepo();
  final RankRateRepo rankRateRepo = RankRateRepo();

  GraphModel() {
    _fetchAll();
  }

  /// 指定されたタグに該当するレコードのリストを取得する
  void _getTagRecordList(String tagName) {
    final tag = allTagList.where((tag) => tag.tag == tagName).toList()[0];
    tagRecordList =
        allRecordList.where((record) => record.tagId == tag.tagId).toList();
  }

  /// 指定されたタグに該当するMappingのリストを取得する
  void _getTagMappingList() {
    final List<MappingNameRecord> list = [];
    for (final mapping in allMappingList) {
      for (final record in tagRecordList) {
        if (mapping.recordId == record.recordId) {
          list.add(mapping);
        }
      }
    }
    tagMappingList = list;
  }

  /// 指定されたタグに該当する名前のリストを取得する
  void _getTagNameList() {
    final List<Name> list = [];
    for (final mapping in tagMappingList) {
      for (final name in allNameList) {
        if (mapping.nameId == name.nameId) {
          list.add(name);
        }
      }
    }
    tagNameList = list;
  }

  /// 指定されたタグに該当するRecordContentsのリストを取得する
  void _getTagRecordContentsList() {
    final List<RecordContents> list = [];
    for (final record in tagRecordList) {
      for (final recordContents in allRecordContentsList) {
        if (record.recordId == recordContents.recordId) {
          list.add(recordContents);
        }
      }
    }
    tagRecordContentsList = list;
  }

  /// スコア用Mapを初期化
  void _initScoreMap() {
    for (final name in tagNameList) {
      scoreMap[name.name] = [0];
    }
  }

  /// 名前があるかどうかの判定用Mapを初期化
  void _initNameCheckMap() {
    for (final name in tagNameList) {
      nameCheckMap[name.name] = 0;
    }
  }

  /// 指定されたタグに該当するスコアを名前ごとにMapで取得
  /// 
  /// ex. {a:[0,1,2,4], b:[0,2,4,6]}
  void _getTagScore() {
    for (final contents in tagRecordContentsList) {
      for (final name in tagNameList) {
        if (name.nameId == contents.nameId) {
          scoreMap[name.name]
              .add(scoreMap[name.name].last + contents.calcScore);
          nameCheckMap[name.name]++;
          nameCheckMap.forEach((key, value) {
            if (value < nameCheckMap[name.name] - 1) {
              scoreMap[key].add(scoreMap[key].last);
              nameCheckMap[key]++;
            }
          });
        }
      }
    }
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAllRecords();
    allTagList = await tagRepo.getAllTag();
    allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    allNameList = await nameRepo.getAllName();
    allMappingList = await mappingRepo.getAllMapping();

    _getTagRecordList('default');
    _getTagMappingList();
    _getTagNameList();
    _getTagRecordContentsList();
    _initScoreMap();
    _initNameCheckMap();
    _getTagScore();
  }
}
