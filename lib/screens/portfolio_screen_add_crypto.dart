
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCryptoToChart extends StatefulWidget {
  const AddCryptoToChart({Key? key}) : super(key: key);

  @override
  _AddCryptoToChartState createState() => _AddCryptoToChartState();
}

class _AddCryptoToChartState extends State<AddCryptoToChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your Crypto"),
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
