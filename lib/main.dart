import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite_flutter/src/pages/home_page.dart';
import 'package:qrscanner_sqlite_flutter/src/pages/map_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home'    : (BuildContext context)  => HomePage(),
        'map'     : (BuildContext context)  => MapPage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}