import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:influenca/brand/bHome.dart';
import 'package:influenca/brand/bRegistrationScreen.dart';
import 'package:influenca/influencer/iHome.dart';
import 'package:influenca/RoundedButton.dart';
import 'package:influenca/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:influenca/WelcomeScreen.dart';

class cLogin extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _cLoginState createState() => _cLoginState();
}

class _cLoginState extends State<cLogin> {
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    child: Image.asset('images/brand-01.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 76, 76, 76)),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kcTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 76, 76, 76))),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                style: const TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kcTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77))),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Login',
                colour: Color.fromARGB(255, 110, 153, 247),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    if (newUser != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => bHome()));
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => cRegistrationScreen())));
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        )),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
