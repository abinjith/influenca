import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:influenca/influencer/iHome.dart';
import 'package:influenca/RoundedButton.dart';
import 'package:influenca/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:influenca/influencer/influenser_login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _sSignup = FirebaseFirestore.instance;
  bool showSpinner = false;
  String? iname;
  String? isocial;
  String? iphno;
  String? iemail;

  String? ipassword;

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
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  iname = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 94, 94, 94)),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  iemail = value;
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
                style: TextStyle(color: Color.fromARGB(255, 58, 58, 58)),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  ipassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
                obscureText: false,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  isocial = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Social media account',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 42, 42, 42)),
                keyboardType: TextInputType.phone,
                obscureText: false,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  iphno = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: iemail!, password: ipassword!);

                    await _sSignup.collection('influencer').add({
                      'name': iname,
                      'phn': iphno,
                      'social': isocial,
                      'email': iemail,
                    });

                    if (newUser != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => iLogin()));
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password is too weak.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'weak password',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blueGrey,
                              fontFamily: 'MusticaPro',
                            ),
                          ),
                        ),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()));
                    } else if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Email already exists',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blueGrey,
                              fontFamily: 'MusticaPro',
                            ),
                          ),
                        ),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()));
                    } else {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
