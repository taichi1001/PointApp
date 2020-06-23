import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _databaseVersion = 1;
  static const _databaseName = 'record.db';

  //tableName
  static const recordTableName = 'record';
  static const recordContentsTableName = 'record_contents';
  static const nameTableName = 'name';
  static const correspondenceNameRecordTableName = 'correspondence_name_record';
  static const rankRateTableName = 'rank_rate';


  static final DatabaseService dbProvider = DatabaseService();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future createDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);

    final database = await openDatabase(path,
        version: _databaseVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //not use this sample
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $recordTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        title TEXT NOT NULL,
        number_people INTEGER NOT NULL ,
        is_done INTEGER NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE $recordContentsTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_id INTEGER NOT NULL,
        name_id INTEGER NOT NULL,
        count INTEGER NOT NULL,
        score INTEGER NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE $nameTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        UNIQUE(name)
      )
    ''');
    await database.execute('''
      CREATE TABLE $correspondenceNameRecordTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name_id INTEGER NOT NULL,
        record_id INTEGER NOT NULL,
        UNIQUE(name_id, record_id)
      )
    ''');
    await database.execute('''
      CREATE TABLE $rankRateTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_id INTEGER NOT NULL,
        rank INTEGER NOT NULL,
        rate INTEGER NOT NULL
      )
    ''');
  }
}
