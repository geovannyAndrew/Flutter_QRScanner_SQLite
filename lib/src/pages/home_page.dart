import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite_flutter/src/pages/addresses_page.dart';
import 'package:qrscanner_sqlite_flutter/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(_currentPage),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
}