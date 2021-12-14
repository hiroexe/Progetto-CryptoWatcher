import 'package:flutter/material.dart';

class ChartStats with ChangeNotifier{
  String name ="";
  num price = -1;
  num quantity = -1;


  void chartName(String x) {
    String name = x;
    notifyListeners();
  }

  void chartPrice(num y) {
    num price = y ;
    notifyListeners();
  }

  void chartQuantity(num z) {
    num quantity = z;
    notifyListeners();
  }
}

