//https://github.com/hiroexe/Progetto-CryptoWatcher.git

import 'package:crypto_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home : const HomeScreen(),);
  }
}


