import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';
import 'package:qrscanner_sqlite_flutter/src/utils/keys.dart' as keys;

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {

    final Scan scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
       appBar: AppBar(
         title: Text('Coordinates QR'),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.my_location),
             onPressed: (){},
           )
         ],
       ),
       body: _buildMap(scan),
    );
  }

  Widget _buildMap(Scan scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.latLng,
        zoom: 15
      ),
      layers: [
        _buildLayerMap()
      ],
    );
  }

  TileLayerOptions _buildLayerMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : keys.mapboxAccessToken,
        'id'          : 'mapbox.streets' // streets, dark, light, outdoors, satellite
      }
    );
  }
}