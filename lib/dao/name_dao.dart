import 'package:todo_app/service/database.dart';
import 'package:todo_app/entity/name.dart';

class NameDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.nameTableName;

  Future<int> create(Name name) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, name.toDatabaseJson());
    return result;
  }

  Future<List<Name>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    final todos = result.isNotEmpty
        ? result.map((item) => Name.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  Future<int> update(Name name) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, name.toDatabaseJson(),
        where: 'id = ?', whereArgs: [name.id]);
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
