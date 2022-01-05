class CryptoModel {
  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChange_24h,
    required this.priceChangePercentage_24h,
    required this.totalVolume,
    required this.marketCap,
    required this.marketCapRank,
    required this.circulatingSupply,

  });
  late final String id;
  late final String symbol;
  late final String name;
  late final String image;
  late final num currentPrice;
  late final num priceChange_24h;
  late final num priceChangePercentage_24h;
  late final num totalVolume;
  late final num marketCap;
  late final num marketCapRank;
  late final num circulatingSupply;



  CryptoModel.fromJson(Map<String, dynamic> json){

    id = json['id'] ?? "no id";
    symbol = json['symbol'] ?? "no symbol";
    name = json['name'] ?? "no name";
    image = json['image'] ?? "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579";
    currentPrice = json['current_price'] ?? 0;
    priceChange_24h = json['price_change_24h'] ?? 0;
    priceChangePercentage_24h = json['price_change_percentage_24h'] ?? 0;
    totalVolume = json['total_volume'] ?? 0;
    marketCap = json['market_cap'] ?? 0;
    marketCapRank = json['market_cap_rank'] ?? 0;
    circulatingSupply = json['circulating_supply'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['symbol'] = symbol;
    _data['name'] = name;
    _data['image'] = image;
    _data['current_price'] = currentPrice;
    _data['price_change_24h'] = priceChange_24h;
    _data['price_change_percentage_24h'] = priceChangePercentage_24h;
    _data['total_volume'] = totalVolume;
    _data['market_cap'] = marketCap;
    _data['market_cap_rank'] = marketCapRank;
    _data['circulating_supply'] = circulatingSupply;
    return _data;
  }
}
List<CryptoModel> coinList = [];
List<CryptoModel> coinList2 = [];


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
}
     factory CryptoModel.fromJson(Map<String , dynamic> json) {
    return CryptoModel(

    );
  }
  },
 */