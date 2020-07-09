class Tag {
  int tagId;
  String tag;

  Tag({
    this.tagId,
    this.tag,
  });

  factory Tag.fromDatabaseJson(Map<String, dynamic> data) => Tag(
        tagId: data['name_id'],
        tag: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'tag_id': tagId,
        'tag': tag,
      };
}