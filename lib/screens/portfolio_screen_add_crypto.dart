import 'package:crypto_tracker/provider/portfolio_provider.dart';
import 'package:crypto_tracker/screens/portfolio_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/services/portfolio_preferences_services.dart';
import 'home_screen.dart';

class AddCryptoToChart extends StatefulWidget {
  const AddCryptoToChart({Key? key}) : super(key: key);

  @override
  _AddCryptoToChartState createState() => _AddCryptoToChartState();
}

class _AddCryptoToChartState extends State<AddCryptoToChart> {
  String _inputSymbol = "First try";
  double _inputPrice = -1;
  double _inputQuantity = -1;

  @override
  Widget build(BuildContext context) {
    //ChartStats statsNotifier = Provider.of<ChartStats>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your crypto"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: TextField(
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
              onChanged: (valueN) {
                _inputSymbol = valueN;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
                onChanged: (valueP) {
                  _inputPrice = double.parse(valueP);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the quantity of crypto you bought ',
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
              onChanged: (valueQ) {
                _inputQuantity = double.parse(valueQ);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "btn2",
        backgroundColor: Colors.amber,
        label: const Text("ADD"),
        icon: const Icon(Icons.add),
        onPressed: () {
          /*   context
              .read<ChartStats>()
              .addStats(Stats(_inputSymbol, _inputPrice, _inputQuantity));

        */
          PortfolioPreferences().addPortfolioToDb(_inputSymbol, _inputPrice, _inputQuantity);
          Navigator.pop(context, const PortfolioScreen());


        },
      ),
    );
  }
}

