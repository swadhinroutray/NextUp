import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:nextup/helpers/apiProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';

final email = TextEditingController();
final pass = TextEditingController();
// final _auth = FirebaseAuth.instance;

// ignore: must_be_immutable
class Login extends StatelessWidget {
  AssetImage logo = AssetImage('images/logo.png');
  bool isLoggedIn;
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //GET LOGO HERE

                      Image(
                        image: logo,
                        height: 96,
                        width: 96,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 55,
                          fontWeight: FontWeight.w500,
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
                        "Welcome to nextUP.\n   All set to get started!",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 40, 60, 20),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 30),
                        child: Container(
                          child: TextField(
                            controller: pass,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              filled: true,
                              // fillColor: Colors.white,
                              // hintStyle: TextStyle(color: Colors.black54)
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          //Login button
                          try {
                            final success = await ApiProvider()
                                .login(email.text, pass.text);

                            if (success == true) {
                              email.clear();
                              pass.clear();
                              Navigator.pushNamed(context, '/projects');
                            } else {
                              email.clear();
                              pass.clear();
                              Fluttertoast.showToast(
                                  msg: "Invalid Credentials, Could not log in",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Color(0xff02D4C0),
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.pushNamed(context, '/');
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
                              "Login",
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
