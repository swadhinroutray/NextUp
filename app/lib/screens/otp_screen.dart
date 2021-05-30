import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nextup/helpers/apiProvider.dart';
import 'package:nextup/screens/tasks_screen.dart';

final otp = TextEditingController();

class OTPScreen extends StatelessWidget {
  final String taskID;
  final int stage;
  final String projectID;

  OTPScreen(
      {Key key,
      @required this.taskID,
      @required this.stage,
      @required this.projectID})
      : super(key: key);
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
                        "Verify OTP",
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
                        "An OTP has been sent to you email, verify stage transfer",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 75, 60, 20),
                        child: Container(
                          child: TextField(
                              controller: otp,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: 'OTP',
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
                                .completeStagePropagation(
                                    taskID, otp.text, stage);

                            if (success == true) {
                              otp.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskScreen(
                                            projectID: projectID,
                                          )));
                            } else {
                              otp.clear();
                              await Fluttertoast.showToast(
                                  msg: "Invalid OTP, could not verify!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Color(0xff02D4C0),
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskScreen(
                                            projectID: projectID,
                                          )));
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              "Verify",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 24,
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
