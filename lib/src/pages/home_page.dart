import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite_flutter/src/bloc/scans_bloc.dart';
import 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';
import 'package:qrscanner_sqlite_flutter/src/pages/addresses_page.dart';
import 'package:qrscanner_sqlite_flutter/src/pages/maps_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrscanner_sqlite_flutter/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPage = 0;
  final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => scansBloc.deleteAllScans(),
          )
        ],
      ),
      body: _callPage(_currentPage),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: (index){
        setState(() {
         _currentPage = index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.navigation),
          title: Text('Addresses')
        )
      ],
    );
  }

  Widget _callPage(int currentPage) {
    switch(currentPage){
      case 0: return MapsPage();
      case 1: return AddressesPage();
      default:
        return MapsPage();
    }
  }

  Widget _buildFloatActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () => _scanQR(context),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _scanQR(BuildContext context) async{

    //Posible results
    //https://geobuitrago.dev -> Url
    //geo:40.741923619036605,-73.90294447382814 -> Map Location
    //MATMSG:TO:geovanny.andrew911@gmail.com;SUB:Asunto;BODY:Texto;; -> Email
    
    //String futureString = 'geo:40.741923619036605,-73.90294447382814';
    String futureString;
    
    try {
      futureString = await QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    //print('FutureString $futureString');
    if(futureString != null){
      final scan = Scan(
        value: futureString
      );
      scansBloc.insertScan(scan);
      utils.launchScan(context, scan);
    }
  }
}