

import 'package:crypto_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textSize = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Crypto Tracker',
        theme: ThemeData.dark().copyWith(
          textTheme: textSize.copyWith(
              headline1: textSize.headline1!.copyWith(
              color: Colors.white,
              ),
              headline2: textSize.headline2!.copyWith(
              color: Colors.white,
              ),
             headline3: textSize.headline3!.copyWith(
             color: Colors.white,
              ),
            overline: textSize.overline!.copyWith(color:Colors.blueGrey),
          ),
        ),
        home : const HomeScreen(),
    );
  }
}


