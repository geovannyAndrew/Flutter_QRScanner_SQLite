import 'dart:async';

import 'package:qrscanner_sqlite_flutter/src/providers/db_provider.dart';

class ScansBloc{
  static final ScansBloc _singleton = ScansBloc._();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._(){
    
  }

  final _scansController = StreamController<List<Scan>>.broadcast();

  Stream<List<Scan>> get scansStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }
}