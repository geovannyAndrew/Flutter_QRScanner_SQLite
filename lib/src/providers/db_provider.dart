import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
export 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';

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

  //INSERT
  newScanRaw(Scan scan) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO scans (id, type, value) "
      "VALUES ( ${scan.id}, '${scan.type}', '${scan.value}')"
    );
    return res;
  }

  //INSERT
  newScan(Scan scan) async{
    final db = await database;
    final res = await db.insert('scans', scan.toJson());
    return res;
  }

  Future<Scan> getScanId(int id) async{
    final db = await database;
    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Scan.fromJson(res.first) : null;
  }

  Future<List<Scan>> getAllScans() async{
    final db = await database;
    final res = await db.query('scans');

    List<Scan> scans = res.isNotEmpty ? res.map((scanMap) => Scan.fromJson(scanMap)).toList() : [];
    return scans;
  }

  Future<List<Scan>> getScansByType(String type) async{
    final db = await database;
    final res = await db.query('scans', where: 'type = ?', whereArgs: [type]);

    List<Scan> scans = res.isNotEmpty ? res.map((scanMap) => Scan.fromJson(scanMap)).toList() : [];
    return scans;
  }

  Future<int> updateScan(Scan scan) async{
    final db = await database;
    final res = await db.update('scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan( int id) async{
    final db = await database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs:[id]);
    return res;
  }

  Future<int> deleteAllScans() async{
    final db = await database;
    final res = await db.rawDelete('DELETE from scans');
    return res;
  }

}