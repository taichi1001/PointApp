class Record {
  int id;
  String title;
  int numberPeople;
  bool isDone;

  Record({this.id, this.title, this.numberPeople = 1, this.isDone = false});

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
        id: data['id'],
        title: data['title'],
        numberPeople: data['number_people'],
        isDone: data['is_done'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "title": this.title,
        "number_people": this.numberPeople,
        "is_done": this.isDone ? 1 : 0,
      };
}
