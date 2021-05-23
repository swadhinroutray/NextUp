import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './signup.dart';
import './login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFCE944),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: 110.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      //PUT LOGO HERE
                      // Image(
                      //   image: AssetImage('images/c.jpg'),
                      //   height: 106,
                      //   width: 106,
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'nextUP',
                        style: TextStyle(
                          // color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 60.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          'Have trouble managing projects?',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.0,
                                  ),
                                ),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUp();
                                  }));
                                  //SignupButton
                                },
                              ),
                              height: 50.0,
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Container(
                              child: FlatButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.0,
                                  ),
                                ),
                                color: Color(0xff02D4C0),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login();
                                  }));
                                  //SignupButton
                                },
                              ),
                              height: 50.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
