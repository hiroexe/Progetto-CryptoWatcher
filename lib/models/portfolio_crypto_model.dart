class PortfolioCryptoModel {
  PortfolioCryptoModel({
    required this.symbol,
    required this.image,
    required this.currentPrice,
  });

  late final String symbol;
  late final String image;
  late final num currentPrice;

  PortfolioCryptoModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] ?? "no symbol";
    image = json['image'] ?? "no image";
    currentPrice = json['current_price'] ?? "no price";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['symbol'] = symbol;
    _data['image'] = image;
    _data['current_price'] = currentPrice;

    return _data;
  }
}

List<PortfolioCryptoModel> portfolioList = [];
