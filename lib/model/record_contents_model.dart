import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_app/entity/rank_rate.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/repository/rank_rate_repository.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  final Record record;
  NameModel nameModel;

  List<RecordContents> _allRecordContentsList = [];
  List<RecordContents> _recordContentsList = [];
  List<List<RecordContents>> _recordContentsPerCount = [];
  List<RankRate> _recordRankRateList = [];
  Map<String, int> _scoreMap = {};
  int _count = 0;

  List<RecordContents> get allRecordContentsList => _allRecordContentsList;
  List<RecordContents> get recordContentsList => _recordContentsList;
  List<List<RecordContents>> get recordContentsPerCount =>
      _recordContentsPerCount;
  List<RankRate> get recordRankRateList => _recordRankRateList;
  Map<String, int> get scoreMap => _scoreMap;

  final RecordContentsRepository recordContentsRepo =
      RecordContentsRepository();
  final RankRateRepository rankRateRepo = RankRateRepository();

  RecordContentsModel({this.record}) {
    nameModel = NameModel(record: record);
    fetchAll();
  }

  Future addNewRecordContents(List<TextEditingController> textList) async {
    _count++;
    var index = 0;
    for (final text in textList) {
      await recordContentsRepo.insertRecordContents(
        RecordContents(
          recordId: record.recordId,
          nameId: nameModel.recordNameList[index].nameId,
          count: _count,
          score: int.parse(text.text),
        ),
      );
      index++;
    }
    await fetchAll();
  }

  Future updateRankRate(List<TextEditingController> textList) async {
    var index = 0;
    for (final text in textList) {
      if (recordRankRateList[index].rate != int.parse(text.text)) {
        recordRankRateList[index].rate = int.parse(text.text);
        rankRateRepo.updateRankRate(recordRankRateList[index]);
      }
      index++;
    }
    await fetchAll();
  }

  Future initRankRate() async {
    if (recordRankRateList.isEmpty) {
      for (int rank = 1; rank <= nameModel.recordNameList.length; rank++) {
        await rankRateRepo.insertRankRate(
          RankRate(
            recordId: record.recordId,
            rank: rank,
          ),
        );
      }
    }
  }

  void calcScore() {
    _initScore();
    if (record.mode == '順位モード') {
      if (!record.isDuplicate) {
        _calcByRankMode();
      } else {
        _calculateByRankDuplicateMode();
      }
    } else {
      _calcByScoreMode();
    }
  }

  void _initScore() {
    for (final name in nameModel.recordNameList) {
      _scoreMap[name.name] = 0;
    }
  }

  void _calcByScoreMode() {
    for (final name in nameModel.recordNameList) {
      for (final contents in recordContentsList) {
        if (name.nameId == contents.nameId) {
          _scoreMap[name.name] = _scoreMap[name.name] + contents.score;
          break;
        }
      }
    }
  }

  void _calcByRankMode() {
    for (final name in nameModel.recordNameList) {
      for (final contents in recordContentsList) {
        if (name.nameId == contents.nameId) {
          for (final rankRate in recordRankRateList) {
            if (contents.score == rankRate.rank) {
              _scoreMap[name.name] = _scoreMap[name.name] + rankRate.rate;
              break;
            }
          }
        }
      }
    }
  }

  void _calculateByRankDuplicateMode() {
    _initScore();
    for (final perCount in recordContentsPerCount) {
      final List<List<RecordContents>> dupLists = _makeDuplists(perCount);
      final List<List<RecordContents>> dupListsB =
          _removeDuplicateFromDuplists(dupLists);
      final List<RecordContents> flatDupList =
          dupListsB.expand((pair) => pair).toList();
      final List<RecordContents> noDupList =
          perCount.where((element) => !flatDupList.contains(element)).toList();
      _calcContentsScoreNoDupList(noDupList);
      if (dupListsB.isEmpty) {
        return;
      } else {
        for (final dupList in dupListsB) {
          final dupRate = _calcRateDuplicatedScore(dupList);
          _calcDuplicatedScore(dupList, dupRate);
        }
      }
    }
  }

  void _calcDuplicatedScore(List<RecordContents> dupList, int dupRate) {
    for (final name in nameModel.recordNameList) {
      for (final contents in dupList) {
        if (name.nameId == contents.nameId) {
          scoreMap[name.name] = scoreMap[name.name] + dupRate;
        }
      }
    }
  }

  int _calcRateDuplicatedScore(List<RecordContents> dupList) {
    var dupRate = 0;
    for (int i = 0; i < dupList.length; i++) {
      for (final rankRate in recordRankRateList) {
        if (dupList[0].score + i == rankRate.rank) {
          dupRate += rankRate.rate;
        }
      }
    }
    dupRate = (dupRate / dupList.length).round();
    return dupRate;
  }

  void _calcContentsScoreNoDupList(List<RecordContents> noDupList) {
    for (final name in nameModel.recordNameList) {
      for (final contents in noDupList) {
        if (name.nameId == contents.nameId) {
          for (final rankRate in recordRankRateList) {
            if (contents.score == rankRate.rank) {
              _scoreMap[name.name] = _scoreMap[name.name] + rankRate.rate;
              break;
            }
          }
        }
      }
    }
  }

  // _makeDuplistsで生じる同じ組み合わせのうちの1つを削除する
  List<List<RecordContents>> _removeDuplicateFromDuplists(
      List<List<RecordContents>> dupLists) {
    var rank = 0;
    final List<List<RecordContents>> dupListsB = [];
    for (final dupList in dupLists) {
      if (rank != dupList[0].score) {
        dupListsB.add(dupList);
        rank = dupList[0].score;
      }
    }
    return dupListsB;
  }

  List<List<RecordContents>> _makeDuplists(List<RecordContents> perCount) {
    final List<List<RecordContents>> dupLists = [];
    for (final recordContents1 in perCount) {
      int dupCount = 0;
      final List<RecordContents> dupList = [];
      for (final recordContents2 in perCount) {
        if (recordContents1.score == recordContents2.score) {
          dupCount++;
          if (dupCount == 2) {
            dupList.add(recordContents1);
            dupList.add(recordContents2);
            dupLists.add(dupList);
          } else if (dupCount > 2) {
            dupList.add(recordContents2);
            dupLists.add(dupList);
          }
        }
      }
    }
    return dupLists;
  }

  void _sortScore() {
    final sortedKeys = _scoreMap.keys.toList(growable: false)
      ..sort((k1, k2) => _scoreMap[k2].compareTo(_scoreMap[k1]));
    final LinkedHashMap<String, int> sortedMap = LinkedHashMap.fromIterable(
        sortedKeys,
        key: (k) => k,
        value: (k) => _scoreMap[k]);
    _scoreMap = sortedMap;
  }

  void _getRecordContentsPerCount() {
    final List<List<RecordContents>> __recordContentsPerCount = [];

    for (int count = 1; count <= _count; count++) {
      final List<RecordContents> perCount = [];
      for (final recordContents in _recordContentsList) {
        if (recordContents.count == count) {
          perCount.add(recordContents);
        }
      }
      __recordContentsPerCount.add(perCount);
    }
    _recordContentsPerCount = __recordContentsPerCount;
  }

  void _getRecordContentsList() {
    _recordContentsList = _allRecordContentsList
        .where((recordContents) => recordContents.recordId == record.recordId)
        .toList();
  }

  void _getCount() {
    int count = 0;
    if (_recordContentsList.isNotEmpty) {
      count = _recordContentsList
          .map((recordContents) => recordContents.count)
          .toList()
          .reduce(max);
    }
    _count = count;
  }

  Future fetchAll() async {
    _allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    _recordRankRateList = await rankRateRepo.getRankRateByID(record.recordId);
    _getRecordContentsList();
    _getCount();
    _getRecordContentsPerCount();
    calcScore();
    _sortScore();
    notifyListeners();
  }

  Future add(RecordContents recordContents) async {
    await recordContentsRepo.insertRecordContents(recordContents);
    fetchAll();
  }

  Future update(RecordContents recordContents) async {
    await recordContentsRepo.updateRecordContents(recordContents);
    fetchAll();
  }

  Future remove(RecordContents recordContents) async {
    await recordContentsRepo
        .deleteRecordContentsById(recordContents.recordContentsId);
    fetchAll();
  }
}
