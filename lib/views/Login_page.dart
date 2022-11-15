import 'dart:async';

import 'package:flutter/material.dart';
import '../views/home_page.dart';

TextEditingController getUser = new TextEditingController();
TextEditingController getPass = new TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          body: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.red[900],
                        fontSize: 32,
                        letterSpacing: 4.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Login to Explore Amazing Things',
                    style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 18,
                        letterSpacing: 1.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: getUser,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            left: 30.0, top: 20.0, bottom: 20.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        labelText: ('Username'),
                        labelStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        obscureText: true,
                        controller: getPass,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 30.0, top: 20.0, bottom: 20.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.red,
                          ),
                          labelText: ('Password'),
                          labelStyle: TextStyle(color: Colors.red),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              // Page Register
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.red[900],
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              // nanti kita arahkan kehalaman login
                              //default user
                              String user = 'belajar';
                              String pass = '1234';
                              if (getUser.text == user &&
                                  getPass.text == pass) {
                                //delay to Home page
                                Timer(Duration(seconds: 2), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                });
                              } else {
                                final errorUser = SnackBar(
                                  content: Text('Cek kembali input anda!'),
                                  duration: Duration(seconds: 2),
                                );
                              }
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
