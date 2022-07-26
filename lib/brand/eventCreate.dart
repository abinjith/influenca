import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:influenca/brand/bHome.dart';
import 'package:influenca/influencer/iHome.dart';
import 'package:influenca/RoundedButton.dart';
import 'package:influenca/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class eventCreate extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _eventCreateState createState() => _eventCreateState();
}

class _eventCreateState extends State<eventCreate> {
  final _auth = FirebaseAuth.instance;
  final _csign = FirebaseFirestore.instance;
  bool showSpinner = false;
  String? cname;
  //String? ktureg;
  //String? branch;
  String? ename;
  String? edate;
  String? etime;
  String? evenu;
  String? edisc;

  DateTime selectedDate = DateTime.now();

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
                    child: Image.asset('images/logo.jpg'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  ename = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Event name'),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  etime = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Event Time'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  evenu = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Event venue'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  edisc = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Event description'),
              ),
              SizedBox(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'select date',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        _selectDate(context);
                        //
                        // to make sure that no keyboard is shown after selecting Date
                        FocusScope.of(context).unfocus();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.zero,
                        ),
                      ),
                      child: Text(
                        '${selectedDate.day}${months[selectedDate.month - 1]}',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register Event',
                colour: Color(0xfffe8378),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    // final newUser = await _auth.createUserWithEmailAndPassword(
                    //     email: cemail!, password: cpassword!);

                    await _csign.collection('createevent').add({
                      'eName': ename,
                      'eDate': edate,
                      'eTime': etime,
                      'eVenue': evenu,
                      'eDesc': edisc,
                    });

                    //if (newUser != null) {}
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => bHome()));

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
