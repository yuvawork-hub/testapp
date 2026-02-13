import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/common/app_constants.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  late Dio dio;

  String? _token;

  DioClient(
    this.baseUrl, {
    required this.loggingInterceptor,
    required this.sharedPreferences,
  }) {
    _token = sharedPreferences.getString(AppConstants.userLoginToken);

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: _buildHeaders(),
      ),
    );

    dio.interceptors.add(loggingInterceptor);

    if (kDebugMode) {
      log("Dio Initialized with Token: $_token");
    }
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }

  void updateHeader({String? token, String? countryCode}) {
    if (token != null) {
      _token = token;
    }

    dio.options.headers = _buildHeaders();
  }

  // =========================
  // HTTP METHODS
  // =========================

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on SocketException {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Unable to process data");
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive Timeout";
      case DioExceptionType.badResponse:
        return "Server Error: ${error.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request Cancelled";
      default:
        return "Unexpected Error";
    }
  }
}
