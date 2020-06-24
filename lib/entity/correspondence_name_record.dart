class CorrespondenceNameRecord {
  int correspondenceId;
  int nameId;
  int recordId;

  CorrespondenceNameRecord({this.correspondenceId, this.nameId, this.recordId});

  factory CorrespondenceNameRecord.fromDatabaseJson(
          Map<String, dynamic> data) =>
      CorrespondenceNameRecord(
          correspondenceId: data['id'], nameId: data['name_id'], recordId: data['record_id']);

  Map<String, dynamic> toDatabaseJson() => {
        'id': correspondenceId,
        'name_id': nameId,
        'record_id': recordId,
      };
}
