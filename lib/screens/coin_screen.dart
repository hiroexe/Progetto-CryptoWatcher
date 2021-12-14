import 'dart:async';
import 'dart:convert';
import 'package:crypto_tracker/models/chart_sample_data_model.dart';
import 'package:flutter/material.dart';
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
          title: Row (
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('|  ',),
                Text(symbol.toUpperCase()),
                const Text('/USD')
              ]




          ),
        ),
        body: ListView  (
          scrollDirection: Axis.vertical,
          children: <Widget>[

          SizedBox(
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
                          ? priceChangePercentage_24h.toDouble()
                          .toStringAsFixed(2) + '%'
                          : '+' + priceChangePercentage_24h.toDouble()
                          .toStringAsFixed(2) + '%',
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








           SfCartesianChart(
               series: <CandleSeries>[
                CandleSeries<ChartSampleData, DateTime> (
                    enableSolidCandles: true,
                    dataSource: data,
                    xValueMapper: (ChartSampleData sales, _) => sales.x,
                    lowValueMapper: (ChartSampleData sales, _) => sales.low,
                    highValueMapper: (ChartSampleData sales, _) => sales.high,
                    openValueMapper: (ChartSampleData sales, _) => sales.open,
                    closeValueMapper: (ChartSampleData sales, _) => sales.close),
                ],
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.MMMd(),
                  majorGridLines: const MajorGridLines(width: 0),
                  ),
                primaryYAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 1),
                    minimum: currentPrice / 1.1,
                    maximum: currentPrice * 1.1,
                    interval: currentPrice / 13,
                    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2)),
                ),


         SizedBox(
           height:60,
           child: BottomNavigationBar(
             items: const <BottomNavigationBarItem>[
               BottomNavigationBarItem(
                 icon: Icon(Icons.trending_up),
                 label: '1d',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.star),
                 label : ('1m'),
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.pie_chart),
                 label: '1y',
               ),
             ],
             selectedItemColor: Colors.amber[800],

           )

         ),






        SizedBox(
          height:100,
          width: 100,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                          Text(' '),
                          Text('Total Volume:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text('Circulating Supply:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text('MarketCap:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text('MarketCap Rank:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),



                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(' '),
                        Text(totalVolume.round().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),),
                        Text(circulatingSupply.round().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),),
                        Text("${marketCap.toStringAsFixed(0)} M",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),),
                        Text(marketCapRank.toStringAsFixed(0),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),),



                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
      ],
        ),

        );


  }
}

