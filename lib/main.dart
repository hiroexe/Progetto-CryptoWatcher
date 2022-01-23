/*
https://github.com/hiroexe/Progetto-CryptoWatcher.git
 */

import 'package:crypto_tracker/screens/wrapper.dart';
import 'package:crypto_tracker/screens/portfolio_screen.dart';
import 'package:crypto_tracker/screens/portfolio_screen_add_crypto.dart';
import 'package:crypto_tracker/services/auth_services.dart';
import 'package:crypto_tracker/services/portfolio_preferences_services.dart';
import 'package:crypto_tracker/services/watchlist_preferences_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WatchlistPreferences.init();
  await PortfolioPreferences.init();
  runApp( const MyApp(),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget();
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [

                ChangeNotifierProvider<AuthServices>.value
                  (value: AuthServices()),
                StreamProvider<User?>.value(
                    value: AuthServices().user,
                    initialData: null),

              ],
              child: MaterialApp(

                theme: ThemeData.dark(),
                debugShowCheckedModeBanner: false,
                home: const Wrapper(),
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Icon(Icons.error),
            Text("Something went wrong")
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: ListView(
          children: const [
            SizedBox(height: 150),
            Center(
              child: SizedBox(
                height: 30,
                child: Text(
                  'CRYPTOWATCHER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              height: 20,
              width: 20,
            ),
          ],


        ),
      ),
    );

  }
}
