import 'package:crypto_tracker/screens/coin_screen.dart';
import 'package:flutter/material.dart';


class WatchListProvider with ChangeNotifier {
  final List<CoinScreen> _watchList = [];

  List <CoinScreen> get watchList => _watchList;


  addToWatchList (CoinScreen crypto){
    bool a = true;
    if (watchList.isNotEmpty) {
      for (int i = 0; i < watchList.length; i++) {
        if (watchList[i].name == crypto.name) {
          a = false;
          notifyListeners();
        }

      }
    }
    if (a == true) {
      watchList.add(crypto);
      notifyListeners();
    }
  }

  removeFormWatchList (index){
    _watchList.removeWhere((_) => _.id == _watchList[index].id);

  }
}