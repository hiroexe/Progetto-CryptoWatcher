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

/*
class CryptoData {
  CryptoData(this.name, this.price);
   String? name;
   num? price;
}

List<CryptoData> getChartData() {
  List<CryptoData> chartData = [
        CryptoData(ChartStats().nameProvider, ChartStats().quantityProvider)
  ];
  debugPrint("Name ${ChartStats().nameProvider}");
  debugPrint(ChartStats().quantityProvider.toString());
  return chartData;
}

 */
class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

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
              DoughnutSeries<Stats, String>(
                dataSource: ChartStats().statsList,
                xValueMapper: (Stats data, _) =>
                    context.watch<ChartStats>().statsList[0].name,
                yValueMapper: (Stats data, _) =>
                    context.watch<ChartStats>().statsList[0].quantity,
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
