/*
https://github.com/hiroexe/Progetto-CryptoWatcher.git
 */

import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:crypto_tracker/screens/home_screen.dart';
import 'package:crypto_tracker/screens/portfolio_screen.dart';
import 'package:crypto_tracker/screens/portfolio_screen_add_crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => ChartStats(),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/screens/portfolio_screen': (context) => const PortfolioScreen(),
        '/screens/portfolio_screen_add_crypto': (context) =>
            const AddCryptoToChart(),
      },
      home: const HomeScreen(),
    );
  }
}
