import 'package:flutter/material.dart';

class RankRate with ChangeNotifier {
  int id;
  int recordId;
  int rank;
  int rate;

  RankRate({this.id, this.recordId, this.rank, this.rate = 1});

  factory RankRate.fromDatabaseJson(Map<String, dynamic> data) =>
      RankRate(
        id: data['id'],
        recordId: data['record_id'],
        rank: data['rank'],
        rate: data['rate'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': id,
        'record_id': recordId,
        'rank': rank,
        'rate': rate,
      };
}
