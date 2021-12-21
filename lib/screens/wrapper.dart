import 'package:crypto_tracker/screens/auth/authentication_screen.dart';
import 'package:crypto_tracker/screens/auth/signIn_screen.dart';
import 'package:crypto_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null) {
      return HomeScreen();
    } else {
      return Authentication();
    }

  }
}
