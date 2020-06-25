import 'package:flutter/material.dart';
import 'package:todo_app/repository/record_contents_repository.dart';

class RecordContents with ChangeNotifier {
  int recordContentsId;
  int recordId;
  int nameId;
  int count;
  int score;

  RecordContents({this.recordContentsId, this.recordId, this.nameId, this.count, this.score});

  factory RecordContents.fromDatabaseJson(Map<String, dynamic> data) =>
      RecordContents(
        recordContentsId: data['record_contents_id'],
        recordId: data['record_id'],
        nameId: data['name_id'],
        count: data['count'],
        score: data['score'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'record_contents_id': recordContentsId,
        'record_id': recordId,
        'name_id': nameId,
        'count': count,
        'score': score,
      };
  
  /// TextFieldから呼び出す用に仕方なくここに実装している
  void changeScore(String newScore) {
    score = int.parse(newScore);
    notifyListeners();
    final repo = RecordContentsRepository();
    repo.updateRecordContents(this);
  }
}
