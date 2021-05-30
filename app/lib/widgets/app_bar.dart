import 'package:flutter/material.dart';
import 'package:nextup/screens/create_project_screen.dart';
import 'package:nextup/screens/home_screen.dart';
import 'package:nextup/helpers/apiProvider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title = "NextUP";

  CustomAppBar({
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateProjectScreen();
              }));
            }),
        IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final code = await ApiProvider().logout();
              if (code == 200) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              }
            }),
      ],
    );
  }
}
