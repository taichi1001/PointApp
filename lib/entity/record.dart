
class Record {
  int id;
  String title;
  int numberCount;
  bool isDone;

  Record({this.id, this.title, this.numberCount = 1, this.isDone = false});

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
    id: data['id'],
    title: data['title'],
    numberCount: data['number_count'],
    isDone: data['is_done'] == 1 ? true : false,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "number_count": this.numberCount,
    "is_done": this.isDone ? 1 : 0,
  };
}