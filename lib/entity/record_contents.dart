class RecordContents {
  int id;
  int recordId;
  int count;
  String name;
  int score;

  RecordContents({this.id, this.recordId, this.count, this.name, this.score});

  factory RecordContents.fromDatabaseJson(Map<String, dynamic> data) => RecordContents(
    id: data['id'],
    recordId: data['record_id'],
    count: data['count'],
    name: data['name'],
    score: data['score'],
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "record_id": this.recordId,
    "count": this.count,
    "name": this.name,
    "score": this.score,
  };
}