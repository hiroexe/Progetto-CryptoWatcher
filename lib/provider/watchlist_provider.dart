import 'package:crypto_tracker/screens/coin_screen.dart';
import 'package:flutter/material.dart';


class WatchListProvider with ChangeNotifier {
  final List<CoinScreen> _watchList = [];

  List <CoinScreen> get watchList => _watchList;


  addToWatchList (CoinScreen crypto){
    if(!crypto.favorite){
      watchList.add(crypto);
      crypto.favorite = true;
      notifyListeners();
    }
  }

  removeFormWatchList (index){
    _watchList.removeWhere((_) => _.id == _watchList[index].id);

  }
}