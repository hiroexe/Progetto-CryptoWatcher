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

num Earn (num buyPrice , num currentPrice , num quantity){
  num  earn = (currentPrice * quantity) - (buyPrice * quantity);
  return earn;
}
/*
num EarnPercentace (num earn , num ) {
  num earnPercentace =
}

 */

class _PortfolioScreenState extends State<PortfolioScreen> {

  /*
  Future<List<PortfolioCryptoModel>> fetchCoinPortfolio() async {
    portfolioList = [];
    final response = await https.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            portfolioList.add(PortfolioCryptoModel.fromJson(map));
          }
        }if(mounted){
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
    if(mounted) {
      Timer.periodic(const Duration(seconds: 60), (timer) => fetchCoinPortfolio());
      super.initState();
    }
  }

   */

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
    return Center(
      child: Scaffold(
        body: Consumer<ChartStats>(
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


      ),
    );
  }
}
