import "package:shared_preferences/shared_preferences.dart";

class PortfolioPreferences {

  late List<String> portfolio;
  static SharedPreferences _preferences2 = SharedPreferences.getInstance() as SharedPreferences;
  static Future init() async => _preferences2 = await SharedPreferences.getInstance();

  static const _keyPortfolio = 'portfolio';



  Future addPortfolioToDb(String symbol, double buyPrice, double quantity) async {
    portfolio = getPortfolio() ?? [];

    int tmpIndex;
    if (portfolio.contains(symbol)) {
      tmpIndex = portfolio.indexOf(symbol);
      double tmpPrice = double.parse(portfolio[tmpIndex + 1]);
      double tmpQnty = double.parse(portfolio[tmpIndex + 2]);;
      portfolio[tmpIndex + 1] = ((tmpPrice + buyPrice) / 2).toString();
      portfolio[tmpIndex + 2] = (tmpQnty + quantity).toString();
    } else {
      portfolio.add(symbol);
      portfolio.add(buyPrice.toString());
      portfolio.add(quantity.toString());

    }

    await _preferences2.setStringList(_keyPortfolio, portfolio);
  }


  Future removePortfolioToDb(String symbol) async {
    portfolio = getPortfolio() ?? [];
    if (portfolio.contains(symbol)) {
      int tmp = portfolio.indexOf(symbol);
      portfolio.removeAt(tmp + 2);
      portfolio.removeAt(tmp + 1);
      portfolio.removeAt(tmp);
    }
    await _preferences2.setStringList(_keyPortfolio, portfolio);

  }


  List<String>? getPortfolio() {
    return  _preferences2.getStringList(_keyPortfolio);
  }

}