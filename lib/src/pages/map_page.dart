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
  double _zoom = 15;
  String _typeMap = "streets";

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
               mapController.move(scan.latLng, _zoom);
             },
           )
         ],
       ),
       body: _buildMap(scan),
       floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildMap(Scan scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.latLng,
        zoom: _zoom,
        onPositionChanged: (mapPosition, boo){
          _zoom = mapController.zoom;
        }
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
        'id'          : 'mapbox.$_typeMap' // streets, dark, light, outdoors, satellite
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: _changeMapType,
    );
  }

  _changeMapType(){
    if(_typeMap == 'streets'){
      _typeMap = 'dark';
    }
    else if(_typeMap == 'dark'){
      _typeMap = 'light';
    }
    else if(_typeMap == 'light'){
      _typeMap = 'outdoors';
    }
    else if(_typeMap == 'outdoors'){
      _typeMap = 'satellite';
    }
    else{
      _typeMap = 'streets';
    }
    setState(() {
      
    });
  }
}