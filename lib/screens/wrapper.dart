import 'package:crypto_tracker/screens/auth/authentication_screen.dart';
import 'package:crypto_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null) {
      return const HomeScreen();
    } else {
      return Authentication();
    }

  }
}
