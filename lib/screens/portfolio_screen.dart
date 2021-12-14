
import 'package:flutter/material.dart';
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
   String name;
   num price;
}

List<CryptoData> getChartData() {
  final List<CryptoData> chartData = [
    CryptoData("XRP", 50),
    CryptoData("ATOM", 40)
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
            body: Center(
              child: SfCircularChart(
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
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:FloatingActionButton.extended(
          backgroundColor: Colors.amber,
        label: const Text("ADD"),
        icon: const Icon(Icons.add),
        onPressed: () {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const AddCryptoToChart())
         );
        },
      ),

      );

    }
}


