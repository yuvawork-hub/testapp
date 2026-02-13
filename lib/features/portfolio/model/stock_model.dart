class StockModel {
  final String symbol;
  final double price;
  final double esgScore;
  final double co2Emission;
  final double quantity;

  StockModel({
    required this.symbol,
    required this.price,
    required this.esgScore,
    required this.co2Emission,
    this.quantity = 1,
  });

  double get totalValue => price * quantity;
}
