import 'package:flutter/material.dart';
import '../model/stock_model.dart';
import '../service/portfolio_service.dart';

class PortfolioProvider extends ChangeNotifier {
  final PortfolioService service;

  PortfolioProvider({required this.service});

  bool _isLoading = false;
  final List<StockModel> _stocks = [];

  bool get isLoading => _isLoading;
  List<StockModel> get stocks => _stocks;

  /// ===============================
  /// LOAD STOCK AND ADD TO PORTFOLIO
  /// ===============================
  Future<void> loadStock(String symbol) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Fetch in parallel (better performance)
      final results = await Future.wait([
        service.fetchStockPrice(symbol),
        service.fetchESGScore(symbol),
      ]);

      final price = results[0];
      final esgScore = results[1];

      // Fake CO2 calculation for now
      final co2Emission = (100 - esgScore) * 2;

      final stock = StockModel(
        symbol: symbol.toUpperCase(),
        price: price,
        esgScore: esgScore,
        co2Emission: co2Emission,
      );

      _stocks.add(stock);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ===============================
  /// REFRESH ALL STOCKS
  /// ===============================
  Future<void> refreshPortfolio() async {
    if (_stocks.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      for (int i = 0; i < _stocks.length; i++) {
        final price =
            await service.fetchStockPrice(_stocks[i].symbol);

        _stocks[i] = StockModel(
          symbol: _stocks[i].symbol,
          price: price,
          esgScore: _stocks[i].esgScore,
          co2Emission: _stocks[i].co2Emission,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ===============================
  /// TOTAL PORTFOLIO VALUE
  /// ===============================
  double get totalValue {
    return _stocks.fold(
      0,
      (sum, stock) => sum + stock.totalValue,
    );
  }

  /// ===============================
  /// TOTAL CO2 IMPACT
  /// ===============================
  double get totalCarbon {
    return _stocks.fold(
      0,
      (sum, stock) => sum + stock.co2Emission,
    );
  }

  /// ===============================
  /// GREEN SCORE (Weighted)
  /// ===============================
  double get greenScore {
    if (_stocks.isEmpty) return 0;

    final totalESG = _stocks.fold(
      0.0,
      (sum, stock) => sum + stock.esgScore,
    );

    return totalESG / _stocks.length;
  }
}
