import 'package:todo_app/service/database.dart';
import 'package:todo_app/entity/record_contents.dart';

class RecordContentsDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.recordContentsTableName;

  Future<int> create(RecordContents recordContents) async {
    final db = await dbProvider.database;
    var result = db.insert(tableName, recordContents.toDatabaseJson());
    return result;
  }

  Future<List<RecordContents>> getAll() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    List<RecordContents> todos = result.isNotEmpty
        ? result.map((item) => RecordContents.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  Future<int> update(RecordContents recordContents) async {
    final db = await dbProvider.database;
    var result = await db.update(tableName, recordContents.toDatabaseJson(),
        where: "id = ?", whereArgs: [recordContents.id]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //not use this sample
  Future deleteAll() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tableName,
    );

    return result;
  }

}