import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';

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
       body: Center(
         child: Text(scan.value),
       ),
    );
  }
}