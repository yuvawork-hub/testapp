import 'package:testapp/common/app_constants.dart';
import 'package:testapp/core/network/dio/dio_client.dart';
import 'package:testapp/core/network/api_endpoints.dart';
import 'package:testapp/core/network/exception/api_error_handler.dart';

class PortfolioService {
  final DioClient dioClient;

  PortfolioService({required this.dioClient});

  /// ===============================
  /// FETCH STOCK PRICE (Alpha Vantage)
  /// ===============================
  Future<double> fetchStockPrice(String symbol) async {
    try {
      final response = await dioClient.get(
        "https://www.alphavantage.co/query",
        queryParameters: {
          "function": "GLOBAL_QUOTE",
          "symbol": symbol,
          "apikey": AppConstants.alphaVantageApiKey,
        },
      );

      final data = response.data;

      if (data["Global Quote"] != null) {
        return double.parse(data["Global Quote"]["05. price"]);
      } else {
        throw Exception("Stock data not found");
      }
    } catch (e) {
      throw Exception(ApiErrorHandler.getMessage(e));
    }
  }

  /// ===============================
  /// FETCH ESG / CO2 DATA
  /// ===============================
  Future<double> fetchESGScore(String symbol) async {
    try {
      final response = await dioClient.get(
        ApiEndpoints.esg,
        queryParameters: {
          "symbol": symbol,
          "apikey": AppConstants.esgApiKey,
        },
      );

      final data = response.data;

      if (data != null && data["esgScore"] != null) {
        return (data["esgScore"] as num).toDouble();
      } else {
        throw Exception("ESG data not found");
      }
    } catch (e) {
      throw Exception(ApiErrorHandler.getMessage(e));
    }
  }
}
