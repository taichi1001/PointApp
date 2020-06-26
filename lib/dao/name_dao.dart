import 'package:sqflite/sqflite.dart';
import 'package:todo_app/service/database.dart';
import 'package:todo_app/entity/name.dart';

class NameDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.nameTableName;

  Future<int> create(Name name) async {
    try {
      final db = await dbProvider.database;
      final result = db.insert(tableName, name.toDatabaseJson(),
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return result;
    
    // 追加した名前が既にDBにあった場合の処理
    } catch (e) {
      final db = await dbProvider.database;
      final List<Map<String, dynamic>> result = await db
          .query(tableName, where: 'name_id = ?', whereArgs: [name.nameId]);
      final List<Name> names = result.isNotEmpty
          ? result.map((item) => Name.fromDatabaseJson(item)).toList()
          : [];
      // namesには常に値が1つしか入っていない想定
      return names[0].nameId;
    }
  }

  Future<List<Name>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Name> names = result.isNotEmpty
        ? result.map((item) => Name.fromDatabaseJson(item)).toList()
        : [];
    return names;
  }

  Future<int> update(Name name) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, name.toDatabaseJson(),
        where: 'name_id = ?',
        whereArgs: [name.nameId],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'name_id = ?', whereArgs: [id]);
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
