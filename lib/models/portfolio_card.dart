import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:crypto_tracker/screens/portfolio_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PortfolioCard extends StatelessWidget{
  PortfolioCard({
    required this.symbol,
    required this.image,
    required this.currentPrice,
  });
  late final String symbol;
  late final String image;
  late final num currentPrice;


  @override
  Widget build(BuildContext context){
    ChartStats statsNotifier = Provider.of<ChartStats>(context , listen: false);
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
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
                        height: 40,
                        width: 40,
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
                        symbol.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],),
            ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            currentPrice.toDouble().toDouble() < 0
                                ? currentPrice.toDouble().toStringAsFixed(2)
                                : '+' +
                                currentPrice.toDouble().toStringAsFixed(2),
                            style: TextStyle(
                              color: currentPrice.toDouble().toDouble() < 0
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FloatingActionButton.small(
                            heroTag: "btnPortfolio",
                            onPressed: (){
                                statsNotifier.deleteStats(context);
                              },
                            child: const Icon(Icons.delete_outline, color: Colors.white, size: 20, ),
                            backgroundColor: Colors.grey,
                          ),
                  ],
                      ),

              ),
                  ]),
              ),
            ),
    );
  }
}