import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nextup/helpers/apiProvider.dart';
import 'package:nextup/screens/create_project_screen.dart';
import 'package:nextup/screens/home_screen.dart';
import 'package:nextup/screens/tasks_screen.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreen createState() => _ProjectsScreen();
}

class _ProjectsScreen extends State<ProjectsScreen> {
  bool isLoading = true;
  Future<List<dynamic>> projects;
  @override
  void initState() {
    projects = ApiProvider().getUserProjects();
    // print(projects);
    isLoading = false;
    super.initState();
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container();
        }
        if (projectSnap.data == null) {
          return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'No Assigned Project fetched',
                      style: TextStyle(
                        // color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]));
        }

        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            var project = projectSnap.data[index];
            isLoading = false;
            return (buildProjectCard(context, index, project));
          },
        );
      },
      future: projects,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff02D4C0)),
              strokeWidth: 0.3125,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "NextUP",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color(0xff02D4C0),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    tooltip: 'Create a Project',
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateProjectScreen();
                      }));
                    }),
                IconButton(
                    icon: Icon(Icons.logout),
                    tooltip: 'Logout',
                    onPressed: () async {
                      final code = await ApiProvider().logout();
                      if (code == 200) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    }),
              ],
            ),
            body: projectWidget(),
          );
  }

  Widget buildProjectCard(BuildContext context, int index, var project) {
    // final trip = tripsList[index];
    // print(project);
    const colorList = [
      0xff78909c,
      0xff424242,
      0xff37474F,
      0xff424243,
      0xff424244,
      0xff424245,
      0xff424246,
      0xff424247,
      0xff424248,
      0xff424249,
      0xff424250,
      0xff424251,
    ];
    return new Container(
      child: Card(
        color: Color(colorList[Random().nextInt(colorList.length)]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    project['title'],
                    style: new TextStyle(fontSize: 30.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      project['projectID'],
                      style: new TextStyle(fontSize: 12.0),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.arrow_forward),
                        tooltip: 'View this Project',
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskScreen(
                                        projectID: project['projectID'],
                                      )));
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
