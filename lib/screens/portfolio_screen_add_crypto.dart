
import 'dart:async';
import 'dart:convert';
import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:crypto_tracker/models/portfolio_crypto_model.dart';

class AddCryptoToChart extends StatefulWidget {
  const AddCryptoToChart({Key? key}) : super(key: key);

  @override
  _AddCryptoToChartState createState() => _AddCryptoToChartState();
}

class _AddCryptoToChartState extends State<AddCryptoToChart> {

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
        }
        setState(() {
          portfolioList;
        });
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
  String dropDownValue = "Choose the crypto you like to add";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your Crypto"),
      ),
        body :Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter your Crypto symbol',
                hintStyle: const TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(20.0),
              ),
              onChanged: (String) => context.read<ChartStats>().name,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the price you bought your crypto',
                hintStyle: const TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(20.0),
              ),
              onChanged: (num) => context.read<ChartStats>().price,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the quantity of crypto you bought',
                hintStyle: const TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(20.0),
              ),
                onChanged: (num) => context.read<ChartStats>().quantity,
            ),
          ],
        ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton:FloatingActionButton.extended(
         backgroundColor: Colors.amber,
         label: const Text("ADD"),
         icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.pop(context);
        },
        ),
      );
  }

}

