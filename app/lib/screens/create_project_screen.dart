import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:nextup/helpers/apiProvider.dart';

final title = TextEditingController();
final deadline = TextEditingController();
// final _auth = FirebaseAuth.instance;

class CreateProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      //GET LOGO HERE

                      // Image(
                      //   image: AssetImage('images/c.jpg'),
                      //   height: 96,
                      //   width: 96,
                      // ),
                      Text(
                        "Create A Project",
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
                        "Create a new project to collaborate on!",
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
                              controller: title,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              //                 TextField(
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              //   labelText: 'Name',
                              // ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: 'Title',
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
                                // fillColor: Colors.blue,
                                // hintText: ("Enter Username"),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 20),
                        child: Container(
                          child: TextField(
                              controller: deadline,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              //                 TextField(
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              //   labelText: 'Name',
                              // ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: 'Deadline',
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
                                // fillColor: Colors.blue,
                                // hintText: ("Enter Username"),
                              )),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          //Login button
                          try {
                            final success = await ApiProvider()
                                .createProject(title.text, deadline.text);
                            if (success == true) {
                              Fluttertoast.showToast(
                                  msg: "Created project successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Color(0xff02D4C0),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushNamed(context, '/projects');
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
                              "Create",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 27,
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
