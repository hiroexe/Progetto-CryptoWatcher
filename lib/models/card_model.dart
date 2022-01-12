import 'package:crypto_tracker/screens/coin_screen.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  CoinCard({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChange_24h,
    required this.priceChangePercentage_24h,
    required this.totalVolume,
    required this.marketCap,
    required this.marketCapRank,
    required this.circulatingSupply,
  });

  late final String id;
  late final String symbol;
  late final String name;
  late final String image;
  late final num currentPrice;
  late final num priceChange_24h;
  late final num priceChangePercentage_24h;
  late final num totalVolume;
  late final num marketCap;
  late final num marketCapRank;
  late final num circulatingSupply;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 60,
                      width: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.network(image),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          symbol.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currentPrice.toDouble().toStringAsFixed(4),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          priceChange_24h.toDouble() < 0
                              ? priceChange_24h.toDouble().toStringAsFixed(2)
                              : '+' +
                              priceChange_24h.toDouble().toStringAsFixed(2),
                          style: TextStyle(
                            color: priceChange_24h.toDouble() < 0
                                ? Colors.red
                                : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          priceChangePercentage_24h.toDouble() < 0
                              ? priceChangePercentage_24h
                              .toDouble()
                              .toStringAsFixed(2) +
                              '%'
                              : '+' +
                              priceChangePercentage_24h
                                  .toDouble()
                                  .toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                            color: priceChangePercentage_24h.toDouble() < 0
                                ? Colors.red
                                : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoinScreen(
                      id: id,
                      symbol: symbol,
                      name: name,
                      image: image,
                      currentPrice: currentPrice.toDouble(),
                      priceChange_24h: priceChange_24h.toDouble(),
                      priceChangePercentage_24h:
                      priceChangePercentage_24h.toDouble(),
                      totalVolume: totalVolume.toDouble(),
                      marketCap: marketCap.toDouble(),
                      marketCapRank: marketCapRank.toDouble(),
                      circulatingSupply: circulatingSupply.toDouble(),
                    )));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[800],
          )),
    );
  }
}