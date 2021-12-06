import 'package:flutter/material.dart';
import 'package:crypto_tracker/screens/screens.dart';

class CoinScreen extends StatefulWidget {
  final String name;
  final double marketCapRank;
  CoinScreen({required this.name, required this.marketCapRank});

  @override
  CoinScreenState createState() => CoinScreenState(name, marketCapRank);

}


class CoinScreenState extends State<CoinScreen> {
  final String name;
  final double marketCapRank;
  CoinScreenState(this.name, this.marketCapRank);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text (name


          ),
        ),
        body: Text (
            marketCapRank.toString()
        )

    );
  }
}