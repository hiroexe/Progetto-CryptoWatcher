import 'dart:async';
import 'dart:convert';
import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  Future<List<CryptoModel>> fetchCoin() async {
    coinList = [];
    final response = await https.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(CryptoModel.fromJson(map));
          }
        }
        if (mounted) {
          setState(() {
            coinList;
          });
        }
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer timer =
        Timer.periodic(const Duration(seconds: 60), (timer) => fetchCoin());
    if (!mounted) {
      timer.cancel();
    } else {
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: coinList.length,
      itemBuilder: (context, index) {
        return CoinCard(
          id: coinList[index].id,
          name: coinList[index].name,
          symbol: coinList[index].symbol,
          image: coinList[index].image,
          currentPrice: coinList[index].currentPrice.toDouble(),
          priceChange_24h: coinList[index].priceChange_24h.toDouble(),
          priceChangePercentage_24h:
              coinList[index].priceChangePercentage_24h.toDouble(),
          totalVolume: coinList[index].totalVolume.toDouble(),
          marketCap: coinList[index].marketCap.toDouble(),
          marketCapRank: coinList[index].marketCapRank.toDouble(),
          circulatingSupply: coinList[index].circulatingSupply.toDouble(),
        );
      },
    ));
  }
}
