import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influenca/influencer/influenser_login.dart';
import 'package:influenca/WelcomeScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "INFLUENCA",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 37,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Social media marketing platform",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 1, 1)),
              ),
              SizedBox(
                height: 50,
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 15, right: 15),
              //   child: Image(
              //     image: AssetImage("images/logo.png"),
              //     height: 250,
              //     width: 250,
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: ElevatedButton(
                  child: Text("Get Started"),
                  // minWidth: double.infinity,
                  // color: Colors.white,
                  // elevation: 5,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => iLogin()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
