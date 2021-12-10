
class ChartSampleData {

  ChartSampleData({
    required this.x,
    required this.open,
    required this.close,
    required this.low,
    required this.high
  });

  late final DateTime? x;
  late final double? open;
  late final double? close;
  late final double? low;
  late final double? high;


  ChartSampleData.fromJson(List<dynamic> json) {
    x = new DateTime.fromMillisecondsSinceEpoch(json[0]);
    open = json[1];
    close = json[2];
    low = json[3];
    high = json[4];
  }
}

List<ChartSampleData> data = [];

