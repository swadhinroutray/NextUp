import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
      theme: ThemeData.dark().copyWith(
        buttonColor: Colors.black,
        accentColor: Colors.white,
        focusColor: Colors.white,

        // cursorColor: Colors.white,
        // dialogBackgroundColor: Colors.black87
      ),
    ));
  }
}
