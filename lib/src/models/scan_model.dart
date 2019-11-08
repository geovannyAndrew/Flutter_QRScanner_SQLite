import 'dart:convert';
import 'package:latlong/latlong.dart';

Scan scanFromJson(String str) => Scan.fromJson(json.decode(str));

String scanToJson(Scan data) => json.encode(data.toJson());

class Scan {
    int id;
    String type;
    String value;

    Scan({
        this.id,
        this.type,
        this.value,
    }){
      if( this.value.contains('http')){
        this.type = 'http';
      }
      else{
        this.type = 'geo';
      }
    }

    factory Scan.fromJson(Map<String, dynamic> json) => Scan(
        id:     json["id"],
        type:   json["type"],
        value:  json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "type"  : type,
        "value" : value,
    };

    LatLng get latLng{
      final lalo = value.substring(4).split(',');
      final lat = double.parse(lalo[0]);
      final lng = double.parse(lalo[1]);
      return LatLng(lat,lng);
    }
}
