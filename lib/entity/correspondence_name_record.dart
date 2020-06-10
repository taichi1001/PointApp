class CorrespondenceNameRecord {
  int id;
  int nameId;
  int recordId;

  CorrespondenceNameRecord({this.id, this.nameId, this.recordId});

  factory CorrespondenceNameRecord.fromDatabaseJson(Map<String, dynamic> data) =>
      CorrespondenceNameRecord(
        id: data['id'],
        nameId: data['name_id'],
        recordId: data['record_id']
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': id,
        'name_id': nameId,
        'record_id': recordId,
      };
}