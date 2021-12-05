
import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class CryptoData {
  CryptoData(this.name, this.price);
   String name;
   num price;
}

List<CryptoData> getChartData() {
  final List<CryptoData> chartData = [
    CryptoData("XRP", 1,),
    CryptoData("name", 40)
  ];

  return chartData;
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  late List<CryptoData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SfCircularChart(
                title: ChartTitle(text: 'Crypto portfolio \n (in USD)'),
                legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                DoughnutSeries<CryptoData, String>(
                  dataSource: _chartData,
                  xValueMapper: (CryptoData data, _) => data.name,
                  yValueMapper: (CryptoData data, _) => data.price,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                )
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingActionButton.extended(
        onPressed: getChartData,
        backgroundColor: Colors.amber,
        label: Text("ADD"),
        icon: Icon(Icons.add),

      )
    );
    }
}


