import 'dart:async';

import 'package:qrscanner_sqlite_flutter/src/bloc/validator.dart';
import 'package:qrscanner_sqlite_flutter/src/providers/db_provider.dart';

class ScansBloc with Validators{
  static final ScansBloc _singleton = ScansBloc._();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._(){
    getAllScans();
  }

  final _scansController = StreamController<List<Scan>>.broadcast();

  Stream<List<Scan>> get scansStream => _scansController.stream.transform(validateGeo);
  Stream<List<Scan>> get scansStreamHttp => _scansController.stream.transform(validateHttp);

  dispose(){
    _scansController?.close();
  }

  getAllScans() async{
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  deleteScan( int id) async{
    await DBProvider.db.deleteScan(id);
    getAllScans();
  }

  deleteAllScans() async{
    await DBProvider.db.deleteAllScans();
    getAllScans();
  }

  insertScan(Scan scan) async{
    await DBProvider.db.newScan(scan);
    getAllScans();
  }
}