import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

final email = TextEditingController();
final pass = TextEditingController();
// final _auth = FirebaseAuth.instance;

class Login extends StatelessWidget {
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
                        " Login",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 55,
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
                        "We will manage it for you. \n   Welcome to nextUP.\n   All set to get started!",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 75, 60, 20),
                        child: Container(
                          child: TextField(
                              controller: email,
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
                                // fillColor: Colors.blue,
                                // hintText: ("Enter Username"),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 20, 60, 30),
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
                            //SIGN IN USER IMPLEMENTATION

                            // final user = await _auth.signInWithEmailAndPassword(
                            //     email: email.text, password: pass.text);
                            // if (user != null) {
                            //   Navigator.pushNamed(context, '/main');
                            // }
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
