/*
https://github.com/hiroexe/Progetto-CryptoWatcher.git
 */

import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:crypto_tracker/provider/watchlist_provider.dart';
import 'package:crypto_tracker/screens/crypto_screen.dart';
import 'package:crypto_tracker/screens/home_screen.dart';
import 'package:crypto_tracker/screens/portfolio_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ChartStats()),
    ChangeNotifierProvider(create: (_) => WatchListProvider()),
  ],
  child: const MyApp(),
)

);
/*
ChangeNotifierProvider(
create: (_) => ChartStats(),
child: const MyApp(),
)


 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/screens/portfolio_screen': (context) => const PortfolioScreen(),
        '/screens/coin_screen': (context) => const CryptoScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
