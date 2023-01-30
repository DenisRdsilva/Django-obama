import "dart:io" as io;
import 'package:frontproj/example.dart';
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';

class SqliteDB {
  Future<void> getPosts() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'assets/database/db.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });

// Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];
    print(list);
    print(expectedList);

  }
}
