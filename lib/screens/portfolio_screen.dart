import 'dart:async';
import 'dart:convert';

import 'package:crypto_tracker/models/portfolio_card.dart';
import 'package:crypto_tracker/models/portfolio_crypto_model.dart';
import 'package:crypto_tracker/screens/portfolio_screen_add_crypto.dart';
import 'package:crypto_tracker/services/portfolio_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:http/http.dart' as https;
import 'package:collection/collection.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();




}






class _PortfolioScreenState extends State<PortfolioScreen> {

  List<String> portfolioListStats = PortfolioPreferences().getPortfolio() ?? [];

  List<CryptoData>? getChartData() {
    chartData = [];
    for (int i = 0; i < portfolioListStats.length;) {
          chartData.add(CryptoData(portfolioListStats[i],
          double.parse(portfolioListStats[i + 1]),
          double.parse(portfolioListStats[i + 2])));
      //chartData.add(CryptoData("btc", 1000, 1));

      i += 3;}
    print(chartData);
    return chartData;
  }
  Future<List<PortfolioCryptoModel>> fetchCoinPortfolio() async {
    portfolioList = [];
    portfolioListStats = PortfolioPreferences().getPortfolio() ?? [];
    final response = await https.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
              if (portfolioListStats.contains(map.values.elementAt(1))) {
                portfolioList.add(PortfolioCryptoModel.fromJson(map));


            }
              /*  for (int k = 0; k < context
                .read<ChartStats>()
                .statsList
                .length; k++) {
                if (PortfolioCryptoModel
                    .fromJson(map)
                    .symbol ==
                    context
                        .read<ChartStats>()
                        .statsList[k].name && !portfolioList.contains(PortfolioCryptoModel.fromJson(map))) {
                  portfolioList.add(PortfolioCryptoModel.fromJson(map));
                }
              } */


          }
        }
        if(mounted){
          setState(() {
            portfolioList;
          });
        }
      }
      return portfolioList;
    } else {
      throw Exception('Failed to load coins');
    }

  }

  @override
  void initState() {
    portfolioListStats = PortfolioPreferences().getPortfolio() ?? ["Debug", "0", "0"];
    fetchCoinPortfolio();
    super.initState();
    Timer.periodic(
        const Duration(seconds: 15), (timer) => fetchCoinPortfolio());
    _tooltipBehavior = TooltipBehavior(enable: true);
   WidgetsBinding.instance?.addPostFrameCallback((_) {
      PortfolioScreen();
      getChartData();
    //  print(chartData[0].name);

    });
  }



  num earn(num buyPrice, num currentPrice, num quantity) {
    num earn = (currentPrice * quantity) - (buyPrice * quantity);
    return earn;
  }

  late TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Scaffold(

        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            if(portfolioList.isNotEmpty)
            Center(
              child: /*Consumer<CryptoData>(
                builder: (_, notifier, __) => */
                 SfCircularChart(
                  title: ChartTitle(text: 'Crypto portfolio \n (in USD)'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[

                    DoughnutSeries<CryptoData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (CryptoData data, _) =>
                          data.name.toUpperCase(),
                      yValueMapper: (CryptoData data, _) =>
                      (data.quantity  * (portfolioList.firstWhere((element) =>
                      element.symbol == data.name).currentPrice)),
                      dataLabelSettings:
                      const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                    )
                  ],
                //),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  heroTag: const Text("AddBtn"),
                  backgroundColor: Colors.amber,
                  label: const Text("ADD"),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCryptoToChart()));
                  },
                ),
              ),
            ),
            if(portfolioList.isNotEmpty)
              ListView.builder (
               scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: portfolioList.length,
                itemBuilder: (context, index) {
                  return PortfolioCard(
                      symbol: portfolioList[index].symbol,
                      image: portfolioList[index].image,
                      earn: earn(
                        double.parse(portfolioListStats[portfolioListStats.
                        indexOf(portfolioList[index].symbol) + 1]),
                        portfolioList[index].currentPrice,
                        double.parse(portfolioListStats[portfolioListStats.
                        indexOf(portfolioList[index].symbol) + 2]),
                      ),
                      buyPrice: double.parse(portfolioListStats[portfolioListStats.
                  indexOf(portfolioList[index].symbol) + 1]),
                  quantity: double.parse(portfolioListStats[portfolioListStats.
                  indexOf(portfolioList[index].symbol) + 2]),
                    currentPrice: (portfolioList.firstWhere((element) =>
                    element.symbol == portfolioList[index].symbol).currentPrice) ,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

