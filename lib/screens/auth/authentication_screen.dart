import 'package:crypto_tracker/screens/auth/sign_in_screen.dart';
import 'package:crypto_tracker/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;

  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(isToggle) {
      return SignUp(toggleScreen: toggleScreen);
    } else {
      return SignIn(toggleScreen: toggleScreen);
    }
  }
}