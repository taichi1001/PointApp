import 'package:todo_app/service/database.dart';
import 'package:todo_app/entity/correspondence_name_record.dart';

class CorrespondenceNameRecordDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.correspondenceNameRecordTableName;

  Future<int> create(CorrespondenceNameRecord correspondence) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, correspondence.toDatabaseJson());
    return result;
  }

  Future<List<CorrespondenceNameRecord>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<CorrespondenceNameRecord> correspondence = result.isNotEmpty
        ? result
            .map((item) => CorrespondenceNameRecord.fromDatabaseJson(item))
            .toList()
        : [];
    return correspondence;
  }

  Future<int> update(CorrespondenceNameRecord correspondence) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, correspondence.toDatabaseJson(),
        where: 'correspondence_id = ?', whereArgs: [correspondence.correspondenceId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'correspondence_id = ?', whereArgs: [id]);
    return result;
  }

  //not use this sample
  Future deleteAll() async {
    final db = await dbProvider.database;
    final result = await db.delete(
      tableName,
    );

    return result;
  }
}
