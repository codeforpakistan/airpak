import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class AirPakApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('AirPak'),
        //   backgroundColor: Color.fromRGBO(102, 179, 120, 70)
        // ),
        body: HomeScreen(),
      ),
    );
  }
}
