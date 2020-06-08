class Name {
  int id;
  String name;
 

  Name({this.id, this.name,});

  factory Name.fromDatabaseJson(Map<String, dynamic> data) =>
      Name(
        id: data['id'],
        name: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "name":this.name,
      };
}