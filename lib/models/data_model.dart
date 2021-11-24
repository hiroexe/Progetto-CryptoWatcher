
/*
{
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 56956,
    "market_cap": 1074780421371,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1195319135114,
    "total_volume": 31302810442,
    "high_24h": 57851,
    "low_24h": 55938,
    "price_change_24h": -576.745415999008,
    "price_change_percentage_24h": -1.00247,
    "market_cap_change_24h": -12398887459.336548,
    "market_cap_change_percentage_24h": -1.14046,
    "circulating_supply": 18882312,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 69045,
    "ath_change_percentage": -17.46348,
    "ath_date": "2021-11-10T14:24:11.849Z",
    "atl": 67.81,
    "atl_change_percentage": 83940.68525,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2021-11-24T20:26:26.644Z"

     factory CryptoModel.fromJson(Map<String , dynamic> json) {
    return CryptoModel(

    );
  }
  },
 */
class CryptoModel {
  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num changePercentage;

  CryptoModel({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
});

  factory CryptoModel.fromJson(Map<String,dynamic> json){
    return CryptoModel(
        name: json['name'],
        symbol: json['symbol'] ,
        imageUrl: json['imageUrl'] ,
        price: json['price'] ,
        change: json['change'],
        changePercentage: json['changePercentage']
    );
  }
}

List <CryptoModel> coinList = [];




