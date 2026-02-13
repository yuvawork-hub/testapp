import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  final int maxCharactersPerLine;

  LoggingInterceptor({this.maxCharactersPerLine = 200});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      log("╔══════════════════════════════════════════");
      log("║ REQUEST");
      log("╟ METHOD: ${options.method}");
      log("╟ URL: ${options.baseUrl}${options.path}");
      log("╟ HEADERS: ${options.headers}");
      if (options.queryParameters.isNotEmpty) {
        log("╟ QUERY: ${options.queryParameters}");
      }
      if (options.data != null) {
        log("╟ BODY: ${options.data}");
      }
      log("╚══════════════════════════════════════════");
    }

    handler.next(options);
  }

  @override
  void onResponse(
      Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log("╔══════════════════════════════════════════");
      log("║ RESPONSE [${response.statusCode}]");
      log("╟ URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}");

      String responseAsString = response.data.toString();

      if (responseAsString.length > maxCharactersPerLine) {
        for (var i = 0;
            i < responseAsString.length;
            i += maxCharactersPerLine) {
          log(responseAsString.substring(
              i,
              i + maxCharactersPerLine > responseAsString.length
                  ? responseAsString.length
                  : i + maxCharactersPerLine));
        }
      } else {
        log(responseAsString);
      }

      log("╚══════════════════════════════════════════");
    }

    handler.next(response);
  }

  @override
  void onError(
      DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log("╔══════════════════════════════════════════");
      log("║ ERROR");
      log("╟ STATUS: ${err.response?.statusCode}");
      log("╟ MESSAGE: ${err.message}");
      log("╟ URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
      log("╚══════════════════════════════════════════");
    }

    handler.next(err);
  }
}
