import 'package:crypto_tracker/services/portfolio_preferences_services.dart';
import 'package:flutter/material.dart';

class PortfolioCard extends StatelessWidget{
  PortfolioCard({
    required this.symbol,
    required this.image,
    required this.earn,
    required this.currentPrice,
    required this.buyPrice,
    required this.quantity,
  });
  late final String symbol;
  late final String image;
  late final num earn;
  late final num currentPrice;
  late final num buyPrice;
  late final num quantity;



  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 100,
          child: Row(
              children: [
                SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 40,
                    width: 40,
                    child: Container(
                      child: Image.network(image),
                    ),
                  ),
                ),
                SizedBox(width:15),
                SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:40,
                     //   padding: const EdgeInsets.all(0.0),
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
                Expanded(
                  child: Container(
                    height: 100,

                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Buy Price:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Quantity:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Current Price: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Earn:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Text(
                                    buyPrice.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style:  const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    currentPrice.toStringAsFixed(2),
                                    style:  const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    earn.toDouble().toDouble() < 0
                                        ? earn.toDouble().toStringAsFixed(1)
                                        : '+' +
                                        earn.toDouble().toStringAsFixed(1),
                                    style: TextStyle(
                                      color: earn.toDouble().toDouble() < 0
                                          ? Colors.red
                                          : Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                ),


           /*     Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: AlignmentDirectional.centerEnd,
                  width: 35,
                  child: */ Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      FloatingActionButton.small(
                        heroTag: "btnPortfolio",
                        onPressed: (){
                          PortfolioPreferences().removePortfolioToDb(symbol);
                        },
                        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20, ),
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  ),
                //),
              ]),
        ),
      ),
    );
  }
}