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
        "id": this.id,
        "record_id": this.recordId,
        "name_id":this.nameId,
        "count": this.count,
        "score": this.score,
      };
}
