import 'dart:async';
import '../models/scan_model.dart';

class Validators{
  final validateGeo = StreamTransformer<List<Scan>, List<Scan>>.fromHandlers(
    handleData: (scans, sink){
      final geoScans = scans.where((scan){
        return scan.type == 'geo';
      }).toList();
      sink.add(geoScans);
    }
  );

  final validateHttp = StreamTransformer<List<Scan>, List<Scan>>.fromHandlers(
    handleData: (scans, sink){
      final geoScans = scans.where((scan){
        return scan.type == 'http';
      }).toList();
      sink.add(geoScans);
    }
  );
}