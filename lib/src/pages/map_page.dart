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

  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {

    final Scan scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
       appBar: AppBar(
         title: Text('Coordinates QR'),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.my_location),
             onPressed: (){
               mapController.move(scan.latLng, 15);
             },
           )
         ],
       ),
       body: _buildMap(scan),
    );
  }

  Widget _buildMap(Scan scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.latLng,
        zoom: 15
      ),
      layers: [
        _buildLayerMap(),
        _buildMarkers(scan)
      ],
    );
  }

  TileLayerOptions _buildLayerMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : keys.MAPBOX_ACCESS_TOKEN,
        'id'          : 'mapbox.streets' // streets, dark, light, outdoors, satellite
      }
    );
  }

  _buildMarkers(Scan scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100,
          height: 100,
          point: scan.latLng,
          builder: (context){
            return Icon(Icons.location_on,
              size: 45.0,
              color: Theme.of(context).primaryColor,
            );
          }
        )
      ]
    );
  }
}