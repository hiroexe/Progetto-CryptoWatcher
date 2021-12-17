import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_tracker/screens/portfolio_screen_add_crypto.dart';
import 'package:crypto_tracker/provider/portfolio_provider.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class CryptoData {
  CryptoData(this.name, this.price);
  String name = "Debug";
  num price = -1 ;
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  List<CryptoData> getChartData() {
    List<CryptoData> chartData = [];
    for(int i = 0 ; i < context.read<ChartStats>().statsList.length ; i++){
      if(context.watch<ChartStats>().statsList[i].name.isNotEmpty){
          chartData.add(CryptoData(
            context.watch<ChartStats>().statsList[i].name,
            context.watch<ChartStats>().statsList[i].quantity));

          debugPrint("DEBUG " +
              context.watch<ChartStats>().statsList[i].name);
          debugPrint("DEBUG " +
              context.watch<ChartStats>().statsList[i].quantity.toString());
      }
    }
    return chartData;
  }

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
      body: Center(
        child: Consumer<ChartStats>(
          builder: (_, notifier, __) => SfCircularChart(
            title: ChartTitle(text: 'Crypto portfolio \n (in USD)'),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              DoughnutSeries<CryptoData, String>(
                dataSource: getChartData(),
                xValueMapper: (CryptoData data, _) => data.name.toUpperCase(),
                yValueMapper: (CryptoData data, _) => data.price,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
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
    );
  }
}
