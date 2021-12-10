import 'dart:async';
import 'dart:convert';
import 'package:crypto_tracker/models/chart_sample_data_model.dart';
import 'package:crypto_tracker/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/screens/screens.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as https;

class CoinScreen extends StatefulWidget {
  late final String id;
  late final String symbol;
  late final String name;
  late final String image;
  late final double currentPrice;
  late final double priceChange_24h;
  late final double priceChangePercentage_24h;
  late final double totalVolume;
  late final double marketCap;
  late final double marketCapRank;
  late final double circulatingSupply;

  CoinScreen({
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
    required this.circulatingSupply});

  @override
  CoinScreenState createState() => CoinScreenState(id, symbol, name, image, currentPrice,
      priceChange_24h, priceChangePercentage_24h, totalVolume, marketCap, marketCapRank, circulatingSupply);

}


class CoinScreenState extends State<CoinScreen> {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChange_24h;
  final double priceChangePercentage_24h;
  final double totalVolume;
  final double marketCap;
  final double marketCapRank;
  final double circulatingSupply;

  CoinScreenState(this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.priceChange_24h,
      this.priceChangePercentage_24h,
      this.totalVolume,
      this.marketCap,
      this.marketCapRank,
      this.circulatingSupply);

 // late List<ChartSampleData> _chartData;


  Future<List<ChartSampleData>> getChartData1() async {
    data = [];
    final response = await https.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/' + id +
            '/ohlc?vs_currency=usd&days=1'));
    if (response.statusCode == 200) {
      List<dynamic> values = json.decode(response.body);

      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            List<dynamic> list = values[i];
            data.add(ChartSampleData.fromJson(list));

          }
        }
       setState(() {
          data;
        });
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }



  @override
    void initState() {
    getChartData1();
    if(mounted) {
      Timer.periodic(const Duration(seconds: 60), (timer) => getChartData1());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: Text (name

          ),
        ),
        body: Scaffold (
           body: SfCartesianChart(
               series: <CandleSeries>[
                CandleSeries<ChartSampleData, DateTime> (
                    dataSource: data,
                    xValueMapper: (ChartSampleData sales, _) => sales.x,
                    lowValueMapper: (ChartSampleData sales, _) => sales.low,
                    highValueMapper: (ChartSampleData sales, _) => sales.high,
                    openValueMapper: (ChartSampleData sales, _) => sales.open,
                    closeValueMapper: (ChartSampleData sales, _) => sales.close),
                ],
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.MMMd(),
                  majorGridLines: MajorGridLines(width: 0)
                  ),
                primaryYAxis: NumericAxis(
                    minimum: this.currentPrice / 1.1,
                    maximum: this.currentPrice * 1.1,
                    interval: this.currentPrice / 6,
                    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
                ),
           ),
        );


  }
}