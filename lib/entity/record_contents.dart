import 'package:flutter/material.dart';

class RecordContents with ChangeNotifier {
  int recordContentsId;
  int recordId;
  int nameId;
  int count;
  int score;

  RecordContents({this.recordContentsId, this.recordId, this.nameId, this.count, this.score});

  factory RecordContents.fromDatabaseJson(Map<String, dynamic> data) =>
      RecordContents(
        recordContentsId: data['id'],
        recordId: data['record_id'],
        nameId: data['name_id'],
        count: data['count'],
        score: data['score'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': recordContentsId,
        'record_id': recordId,
        'name_id': nameId,
        'count': count,
        'score': score,
      };
}
