import 'package:flutter/material.dart';
import 'package:nextup/screens/create_project_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login.dart';
import 'screens/projects_screen.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => Login(),
        '/projects': (context) => ProjectsScreen(),
        '/createproject': (context) => CreateProjectScreen(),
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
