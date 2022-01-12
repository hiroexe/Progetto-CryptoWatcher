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


