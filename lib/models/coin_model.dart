import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  CoinCard({
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChange_24h,
    required this.priceChangePercentage_24h,
  });

  late final String symbol;
  late final String name;
  late final String image;
  late final num currentPrice;
  late final num priceChange_24h;
  late final num priceChangePercentage_24h;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        height: 100,
        /*
        decoration: BoxDecoration(
          color: Color.fromRGBO(3, 8, 28, 1.0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(4, 4),
              blurRadius: 1,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),

         */
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  /*
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],

                   */
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
                        : '+' + priceChange_24h.toDouble().toStringAsFixed(2),
                    style: TextStyle(
                      color: priceChange_24h.toDouble() < 0 ? Colors.red : Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    priceChangePercentage_24h.toDouble() < 0
                        ? priceChangePercentage_24h.toDouble().toStringAsFixed(2) + '%'
                        : '+' + priceChangePercentage_24h.toDouble().toStringAsFixed(2) + '%',
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
    );
  }
}