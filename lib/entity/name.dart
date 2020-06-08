class Name {
  int id;
  String name;
  String remark;
 

  Name({this.id, this.name, this.remark,});

  factory Name.fromDatabaseJson(Map<String, dynamic> data) =>
      Name(
        id: data['id'],
        name: data['name'],
        remark: data['remark'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "name":this.name,
        "remark": this.remark,
      };
}