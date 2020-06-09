class RecordContents {
  int id;
  int recordId;
  int nameId;
  int count;
  int score;

  RecordContents({this.id, this.recordId, this.nameId, this.count, this.score});

  factory RecordContents.fromDatabaseJson(Map<String, dynamic> data) =>
      RecordContents(
        id: data['id'],
        recordId: data['record_id'],
        nameId: data['name_id'],
        count: data['count'],
        score: data['score'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': id,
        'record_id': recordId,
        'name_id': nameId,
        'count': count,
        'score': score,
      };
}
