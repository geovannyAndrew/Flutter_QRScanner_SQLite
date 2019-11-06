import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'scans.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute(
          "CREATE TABLE scans ("
          " id INTEGER PRIMARY KEY,"
          " type TEXT,"
          " value TEXT"
          ")"
        );
      }
    );
  }

  newScanRaw(Scan scan) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO scans (id, type, value) "
      "VALUES ( ${scan.id}, '${scan.type}', '${scan.value}')"
    );
    return res;
  }

  newScan(Scan scan) async{
    final db = await database;
    final res = db.insert('scans', scan.toJson());
  }
}