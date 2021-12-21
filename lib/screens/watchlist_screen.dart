import 'package:crypto_tracker/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/provider/watchlist_provider.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    WatchListProvider watchListNotifier =
        Provider.of<WatchListProvider>(context, listen: false);

    return Scaffold(
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: watchListNotifier.watchList.length,
          itemBuilder: (context, index) {
         return CoinCard(
          id: watchListNotifier.watchList[index].id,
          name: watchListNotifier.watchList[index].name,
          symbol: watchListNotifier.watchList[index].symbol,
          image: watchListNotifier.watchList[index].image,
          currentPrice:
              watchListNotifier.watchList[index].currentPrice.toDouble(),
          priceChange_24h:
              watchListNotifier.watchList[index].priceChange_24h.toDouble(),
          priceChangePercentage_24h: watchListNotifier
              .watchList[index].priceChangePercentage_24h
              .toDouble(),
          totalVolume:
              watchListNotifier.watchList[index].totalVolume.toDouble(),
          marketCap: watchListNotifier.watchList[index].marketCap.toDouble(),
          marketCapRank:
              watchListNotifier.watchList[index].marketCapRank.toDouble(),
          circulatingSupply:
              watchListNotifier.watchList[index].circulatingSupply.toDouble(),
        );
      },
    ));
  }
}
