
class Repository{
  static String apiUrl = ( 'http://pro-api.coinmarketcap.com/v1');
  final String key = ('eb0c22ba-fbdf-47e7-bb8f-018b18ff812d');

  Future getCoins () async {
    try {} catch (error , stackTrace){
      return('exception $error , dd $stackTrace');
    }

  }
}