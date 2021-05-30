import 'package:flutter/material.dart';
import 'package:nextup/helpers/apiProvider.dart';

final email = TextEditingController();
final pass = TextEditingController();
final name = TextEditingController();
final contact = TextEditingController();
// final _auth = FirebaseAuth.instance;

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  AssetImage logo = AssetImage('images/logo.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFCE944),
      body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 45),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // GET LOGO HERE
                      Image(
                        image: logo,
                        height: 96,
                        width: 96,
                      ),
                      Text(
                        "Sign-Up",
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 55,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                          "Welcome to nextUP.\n Create an account to get started!",
                          style: TextStyle(
                              // color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 30, 60, 20),
                        child: Container(
                          child: TextField(
                            controller: name,
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
                              labelText: 'Name',
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 20),
                        child: Container(
                          child: TextField(
                            controller: contact,
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
                              labelText: 'Contact',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          try {
                            final success = await ApiProvider().register(
                                name.text, email.text, pass.text, contact.text);
                            if (success == true) {
                              name.clear();
                              email.clear();
                              pass.clear();
                              contact.clear();
                              Navigator.pushNamed(context, '/login');
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
