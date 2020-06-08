import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final _databaseVersion = 1;
  static final _databaseName = "record.db";

  //tableName
  static final recordTableName = "record";
  static final recordContentsTableName = "record_contents";

  static final DatabaseService dbProvider = DatabaseService();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    var database = await openDatabase(path,
        version: _databaseVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //not use this sample
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $recordTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        number_people INTEGER NOT NULL ,
        is_done INTEGER NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE $recordContentsTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_id INTEGER NOT NULL,
        count INTEGER NOT NULL,
        name TEXT NOT NULL,
        score INTEGER
      )
    ''');
  }
}
