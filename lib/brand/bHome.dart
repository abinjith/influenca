// ignore: file_names
import 'package:influenca/RoundedButton.dart';
import 'package:influenca/brand/eventCreate.dart';
import 'package:flutter/material.dart';
import 'package:influenca/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class bHome extends StatefulWidget {
  const bHome({Key? key}) : super(key: key);

  @override
  State<bHome> createState() => _cHomeState();
}

void getCurrentUser() {}

// ignore: camel_case_types
class _cHomeState extends State<bHome> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  void getCurrentuser() async {
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => eventCreate()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Hi!  aaaa',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            RoundedButton(
                title: 'Log out',
                colour: const Color(0xff484bf2),
                onPressed: () => FirebaseAuth.instance.signOut())
          ],
        ),
      ),

      //
    );
  }
}
