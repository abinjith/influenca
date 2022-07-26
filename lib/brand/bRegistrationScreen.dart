import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:influenca/brand/bHome.dart';
import 'package:influenca/influencer/iHome.dart';
import 'package:influenca/RoundedButton.dart';
import 'package:influenca/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class cRegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _cRegistrationScreenState createState() => _cRegistrationScreenState();
}

class _cRegistrationScreenState extends State<cRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _csign = FirebaseFirestore.instance;
  bool showSpinner = false;
  String? bname;
  //String? ktureg;
  //String? branch;
  String? bemail;
  String? bphno;
  String? bpassword;
  String? bdesc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  bname = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter brand name'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 30, 30, 30)),
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  bphno = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter description'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
                keyboardType: TextInputType.text,
                obscureText: false,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  bdesc = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  bemail = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 8.0,
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
                        email: bemail!, password: bpassword!);

                    await _csign.collection('brand').add({
                      'name': bname,
                      'phno': bphno,
                      'desc': bdesc,
                      'email': bemail
                    });

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
            ],
          ),
        ),
      ),
    );
  }
}
