class Name {
  int nameId;
  String name;

  Name({
    this.nameId,
    this.name,
  });

  factory Name.fromDatabaseJson(Map<String, dynamic> data) => Name(
        nameId: data['id'],
        name: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': nameId,
        'name': name,
      };
}
