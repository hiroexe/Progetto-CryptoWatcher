import 'dart:async';
import 'dart:convert';

import 'package:crypto_tracker/models/portfolio_card.dart';
import 'package:crypto_tracker/models/portfolio_crypto_model.dart';
import 'package:crypto_tracker/screens/portfolio_screen_add_crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:http/http.dart' as https;

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class CryptoData {
  CryptoData(this.name, this.price);

  String name = "Debug";
  num price = -1;
}

num earn(num buyPrice, num currentPrice, num quantity) {
  num earn = (currentPrice - buyPrice) * quantity;
  return earn;
}
/*
num EarnPercentace (num earn , num ) {
  num earnPercentace =
}

 */

class _PortfolioScreenState extends State<PortfolioScreen> {
  Future<List<PortfolioCryptoModel>> fetchCoinPortfolio() async {
    portfolioList = [];
    pList = [];
    final response = await https.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {

            Map<String, dynamic> map = values[i];
            pList.add(PortfolioCryptoModel.fromJson(map));
            if (pList[i].symbol == context.watch<ChartStats>().statsList[i].name) {
              portfolioList.add(pList[i]);
            }

          }
        }
        if (mounted) {

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
    fetchCoinPortfolio();
    super.initState();
    Timer.periodic(
        const Duration(seconds: 60), (timer) => fetchCoinPortfolio());
    _tooltipBehavior = TooltipBehavior(enable: true);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _chartData = getChartData();
    });
  }

  List<CryptoData> getChartData() {
    List<CryptoData> chartData = [];
    for (int i = 0; i < context.read<ChartStats>().statsList.length; i++) {
      if (context.watch<ChartStats>().statsList[i].name.isNotEmpty) {
        chartData.add(CryptoData(context.watch<ChartStats>().statsList[i].name,
            context.watch<ChartStats>().statsList[i].quantity));

        debugPrint("DEBUG " + context.watch<ChartStats>().statsList[i].name);
        debugPrint("DEBUG " +
            context.watch<ChartStats>().statsList[i].quantity.toString());
      }
    }
    return chartData;
  }

  /*
  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _chartData = getChartData();
    });
  }

   */

  late List<CryptoData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Consumer<ChartStats>(
                builder: (_, notifier, __) => SfCircularChart(
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
                      yValueMapper: (CryptoData data, _) => data.price,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                    )
                  ],
                ),
              ),
            ),
            FloatingActionButton.extended(
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: context.read<ChartStats>().statsList.length,
              itemBuilder: (context, index) {
                return PortfolioCard(
                  symbol: portfolioList[index].symbol,
                  image: portfolioList[index].image,
                  currentPrice: earn(
                      context.watch<ChartStats>().statsList[index].price,
                      portfolioList[index].currentPrice,
                      context.watch<ChartStats>().statsList[index].quantity),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
