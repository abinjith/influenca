import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:influenca/WelcomeScreen.dart';
import 'package:influenca/influencer/influenser_login.dart';
import 'package:influenca/influencer/RegistrationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      // initialRoute: WelcomeScreen(),
      // routes: {
      //   WelcomeScreen.id: (context) => WelcomeScreen(),
      //   sLogin.id: (context) => sLogin(),
      //   RegistrationScreen.id: (context) => RegistrationScreen(),
      // },
    );
  }
}
