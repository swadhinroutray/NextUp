import 'package:flutter/material.dart';
import 'package:nextup/helpers/apiProvider.dart';

import './collaborators_screen.dart';

final email = TextEditingController();

class AddCollaboratorScreen extends StatelessWidget {
  final String projectID;
  AddCollaboratorScreen({Key key, @required this.projectID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(projectID);
    return Scaffold(
      // backgroundColor: Color(0xFFFCE944),
      body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 110),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Task",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          // color: Colors.black,
                        ),
                      )
                    ],
                  ),
//                  SizedBox(
//                    height: ,
//                  ),
                  SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Text(
                        "Add a collaborator!",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 75, 60, 20),
                        child: Container(
                          child: TextField(
                              controller: email,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                filled: true,
                              )),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          //Login button
                          try {
                            final success = await ApiProvider()
                                .addCollaborator(projectID, email.text);
                            if (success == true) {
                              email.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CollaboratorScreen(
                                          projectID: projectID)));
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              "Add Collaborator",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        // color: Colors.black,
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
