import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nextup/helpers/apiProvider.dart';
import 'package:nextup/screens/collaborators_screen.dart';
import 'package:nextup/screens/create_task_screen.dart';
import 'package:nextup/screens/home_screen.dart';
import 'package:nextup/screens/otp_screen.dart';
import 'package:nextup/screens/projects_screen.dart';

class TaskScreen extends StatefulWidget {
  final String projectID;
  TaskScreen({Key key, this.projectID}) : super(key: key);
  @override
  _TaskScreen createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
  bool isLoading = true;
  Future<List<dynamic>> task1, task2, task3, task4, task5;

  @override
  void initState() {
    task1 = ApiProvider().getTasks(widget.projectID, 1);
    task2 = ApiProvider().getTasks(widget.projectID, 2);
    task3 = ApiProvider().getTasks(widget.projectID, 3);
    task4 = ApiProvider().getTasks(widget.projectID, 4);
    task5 = ApiProvider().getTasks(widget.projectID, 5);

    // print(projects);
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NextUP",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xff02D4C0),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.home),
                tooltip: 'View All Projects',
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProjectsScreen()));
                }),
            IconButton(
                icon: Icon(Icons.people),
                tooltip: 'View Collaborators',
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CollaboratorScreen(projectID: widget.projectID)));
                }),
            IconButton(
                icon: Icon(Icons.add_comment),
                tooltip: 'Add new Task',
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateTask(projectID: widget.projectID)));
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
        body: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(text: "Ideation"),
                  Tab(text: "Planning"),
                  Tab(text: "Develop"),
                  Tab(text: "Testing"),
                  Tab(text: "Analysis"),
                ],
                isScrollable: true,
              ),
              title: Text('Project Tasks'),
              centerTitle: true,
            ),
            body: TabBarView(
              children: [
                FutureBuilder(
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No Tasks Fetched',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]));
                    }
                    if (projectSnap.data == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No Tasks Fetched',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]));
                    }
                    return ListView.builder(
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        var project = projectSnap.data[index];
                        print(project);
                        print(project['tasks'][0]);
                        isLoading = false;
                        return (buildProjectCard(context, index, project));
                      },
                    );
                  },
                  future: task1,
                ),
                FutureBuilder(
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      return Container();
                    }
                    if (projectSnap.data == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No assigned or created projects!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
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
                  future: task2,
                ),
                FutureBuilder(
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      return Container();
                    }
                    if (projectSnap.data == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No assigned or created projects!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
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
                  future: task3,
                ),
                FutureBuilder(
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      return Container();
                    }
                    if (projectSnap.data == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No assigned or created projects!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
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
                  future: task4,
                ),
                FutureBuilder(
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No Tasks Fetched!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]));
                    }
                    if (projectSnap.data == null) {
                      return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No Tasks Fetched!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                              ),
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
                  future: task5,
                ),
              ],
            ),
          ),
        ));
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    project['tasks'][0]['taskTitle'],
                    style: new TextStyle(fontSize: 30.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    project['tasks'][0]['description'],
                    style: new TextStyle(fontSize: 15.0),
                    softWrap: true,
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    project['tasks'][0]['taskID'],
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Stage " + project['tasks'][0]['taskStage'].toString(),
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Spacer(),

                    // IconButton(
                    //     icon: Icon(Icons.open_in_full),
                    //     tooltip: 'Open Task',
                    //     onPressed: () async {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => SelectedTaskScreen(
                    //                     projectID: widget.projectID,
                    //           taskID: project['tasks'][0]['taskID']
                    //                   )));
                    //     }),
                    IconButton(
                        icon: Icon(Icons.delete),
                        tooltip: 'Delete this task',
                        onPressed: () async {
                          final success = await ApiProvider().removeTask(
                              widget.projectID, project['tasks'][0]['taskID']);
                          if (success == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskScreen(
                                          projectID: widget.projectID,
                                        )));
                          }
                        }),
                    project['tasks'][0]['taskStage'] == 5
                        ? Container()
                        : IconButton(
                            icon: Icon(Icons.arrow_forward),
                            tooltip: 'Move stage',
                            onPressed: () async {
                              final success = await ApiProvider()
                                  .initiateStagePropagation(
                                      project['tasks'][0]['taskID']);
                              print(success);
                              if (success == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OTPScreen(
                                            taskID: project['tasks'][0]
                                                ['taskID'],
                                            stage: project['tasks'][0]
                                                ['taskStage'],
                                            projectID: widget.projectID)));
                              }
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
