import 'package:todo_app/service/database.dart';
import 'package:todo_app/entity/record_contents.dart';

class RecordContentsDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.recordContentsTableName;

  Future<int> create(RecordContents recordContents) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, recordContents.toDatabaseJson());
    return result;
  }

  Future<List<RecordContents>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<RecordContents> recordContents = result.isNotEmpty
        ? result.map((item) => RecordContents.fromDatabaseJson(item)).toList()
        : [];
    return recordContents;
  }

  Future<int> update(RecordContents recordContents) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, recordContents.toDatabaseJson(),
        where: 'id = ?', whereArgs: [recordContents.id]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
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
