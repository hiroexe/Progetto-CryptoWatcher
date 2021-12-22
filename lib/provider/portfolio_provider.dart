

import 'package:flutter/material.dart';

class Stats{

 String name = "DEBUG";
 num price = 0;
 num quantity = 0;

 Stats(this.name, this.price, this.quantity);

}

class ChartStats with ChangeNotifier{
  final List <Stats> _statsList = [];

  List <Stats> get statsList => _statsList;



  addStats (Stats stats) {
    bool a = true;
    if (statsList.isNotEmpty) {
      for (int i = 0; i < statsList.length; i++) {
        if (statsList[i].name == stats.name) {
          statsList[i].quantity += stats.quantity;
          statsList[i].price = (statsList[i].price + stats.price)/2;
          a = false;
          notifyListeners();
        }
        i++;
      }
    } if (a == true){
      statsList.add(stats);
      notifyListeners();
    }

  }


  deleteStats (index){
    _statsList.removeWhere((_stats) => _stats.name == statsList[index].name);
  }
  clearList (){
    statsList.clear();
  }



}

