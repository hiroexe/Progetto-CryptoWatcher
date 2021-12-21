

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


  addStats (Stats stats){
    int i = 0;
    for (var stats in statsList) {
      if(statsList[i].name == stats.name){
        statsList[i].quantity += stats.quantity;
        print ("true");
      } i++;
      print("false");
    }
      statsList.add(stats);
      notifyListeners();
  }
  isNew (Stats stats) {
    int i = 0;
    for (var stats in statsList) {
      if(statsList[i].name == stats.name){
        statsList[i].quantity += stats.quantity;
        print ("true");
      } i++;
      print("false");
    }
  }


  index (Stats stats){
    int index = 0 ;
      for(int  i = 0 ; i < statsList.length; i++)  {
        if(stats.name == statsList[i].name){
          index = i;
          print("index" + index.toString());
        }
      }
    return index;
  }

  deleteStats (index){
    _statsList.removeWhere((_stats) => _stats.name == statsList[index].name);
  }
  clearList (){
    statsList.clear();
  }



}

