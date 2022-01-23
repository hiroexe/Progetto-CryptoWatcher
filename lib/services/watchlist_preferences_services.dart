import "package:shared_preferences/shared_preferences.dart";

class WatchlistPreferences {
  late List<String> watchlist;
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const _keyWatchlist = 'watchlist';

  Future addCryptoToDb(String id) async {
    watchlist = getWatchlist() ?? [];
    if (!watchlist.contains(id)) {
      watchlist.add(id);
    }
    await _preferences.setStringList(_keyWatchlist, watchlist);
  }

  Future removeCryptoToDb(String id) async {
    watchlist = getWatchlist() ?? [];
    if (watchlist.contains(id)) {
      watchlist.remove(id);
    }
    await _preferences.setStringList(_keyWatchlist, watchlist);
  }

  List<String>? getWatchlist() {
    return _preferences.getStringList(_keyWatchlist);
  }
}
