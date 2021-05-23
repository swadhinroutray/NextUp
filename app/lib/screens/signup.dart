import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

final email = TextEditingController();
final pass = TextEditingController();
// final _auth = FirebaseAuth.instance;

class SignUp extends StatelessWidget {
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
                        " Sign-Up",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 45,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Welcome to nextUP.\n Create an account \n   and get started!",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 50, 60, 20),
                        child: Container(
                          child: TextField(
                            controller: email,
                            style: TextStyle(
                                // color: Colors.black,
                                ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 20),
                        child: Container(
                          child: TextField(
                            controller: pass,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                filled: true,
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          //SignUp button

                          //also check if pwd1==pwd2
                          try {
                            //SIGN UP USER HERE

                            // final user =
                            //     await _auth.createUserWithEmailAndPassword(
                            //         email: email.text, password: pass.text);
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
                          // padding: EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Text(
                              "Sign-Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 28,
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
