import 'package:influenca/influencer/RegistrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:influenca/brand/brand_login.dart';
import 'package:influenca/influencer/iHome.dart';
import 'package:influenca/RoundedButton.dart';
import 'package:influenca/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:influenca/WelcomeScreen.dart';

class iLogin extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _sLoginState createState() => _sLoginState();
}

class _sLoginState extends State<iLogin> {
  get firebase => null;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await firebase.initializeApp();
    return firebaseApp;
  }

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/inflencer.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Influencer Login',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final User = await _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    if (User != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => iHome()));
                    } else {}

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        RegistrationScreen())));
                          },
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            )),
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => cLogin())));
                          },
                          child: Text(
                            'Brand login',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 18,
                              color: Colors.blue,
                            )),
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
