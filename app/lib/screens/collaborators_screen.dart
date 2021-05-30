import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nextup/helpers/apiProvider.dart';
import 'package:nextup/screens/add_collaborator_screen.dart';
import 'package:nextup/screens/home_screen.dart';

class CollaboratorScreen extends StatefulWidget {
  final String projectID;
  CollaboratorScreen({Key key, @required this.projectID}) : super(key: key);
  @override
  _CollaboratorScreen createState() => _CollaboratorScreen();
}

class _CollaboratorScreen extends State<CollaboratorScreen> {
  Future<List<dynamic>> collaborators;
  bool isLoading = true;

  @override
  void initState() {
    collaborators = ApiProvider().getCollaborators(widget.projectID);
    // print(widget.projectID);
    isLoading = false;
    // print(collaborators);
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'No Collaborators exist!',
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
            var collaborator = projectSnap.data[index];
            isLoading = false;
            return (buildProjectCard(context, index, collaborator));
          },
        );
      },
      future: collaborators,
    );
  }

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
                    tooltip: 'Add a Collabolator',
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCollaboratorScreen(
                                  projectID: widget.projectID)));
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

  Widget buildProjectCard(BuildContext context, int index, var collaborator) {
    // final trip = tripsList[index];
    // print(collaborator['data']);
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
                    collaborator['name'],
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
                      collaborator['userID'],
                      style: new TextStyle(fontSize: 12.0),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.delete),
                        tooltip: 'Remove Collaborator',
                        onPressed: () async {
                          var success = await ApiProvider().removeCollaborator(
                              widget.projectID, collaborator['userID']);
                          if (success == true) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CollaboratorScreen(
                                  projectID: widget.projectID);
                            }));
                          }
                        })
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
