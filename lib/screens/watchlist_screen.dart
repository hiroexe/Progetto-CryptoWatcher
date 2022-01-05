import 'dart:async';
import 'dart:convert';
import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:crypto_tracker/services/watchlist_preferences_services.dart';
/*
import 'package:crypto_tracker/provider/watchlist_provider.dart';
import 'package:provider/provider.dart'; */


class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  List<String> watchlistId = [];
  /*  WatchListProvider watchListNotifier =
        Provider.of<WatchListProvider>(context, listen: false); */


  Future<List<CryptoModel>> fetchCoin() async {
    coinList2 = [];
    watchlistId = WatchlistPreferences().getWatchlist() ?? [];
    final response = await https.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            for (int k = 0; k < watchlistId.length; k++) {
              if (map.values.first == watchlistId[k]) {
                coinList2.add(CryptoModel.fromJson(map));
              }
            }
          }
        }
        if (mounted) {
          setState(() {
            coinList2;
          });
        }
      }
      return coinList2;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    watchlistId = WatchlistPreferences().getWatchlist() ?? ["DEBUG", "-1", "-1"];
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
          itemCount: coinList2.length,
          itemBuilder: (context, index) {
            return CoinCard(
              id: coinList2[index].id,
              name: coinList2[index].name,
              symbol: coinList2[index].symbol,
              image: coinList2[index].image,
              currentPrice: coinList2[index].currentPrice.toDouble(),
              priceChange_24h: coinList2[index].priceChange_24h.toDouble(),
              priceChangePercentage_24h:
              coinList2[index].priceChangePercentage_24h.toDouble(),
              totalVolume: coinList2[index].totalVolume.toDouble(),
              marketCap: coinList2[index].marketCap.toDouble(),
              marketCapRank: coinList2[index].marketCapRank.toDouble(),
              circulatingSupply: coinList2[index].circulatingSupply.toDouble(),

            );
          },
        ));
  }
}

