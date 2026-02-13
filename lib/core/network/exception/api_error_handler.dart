import 'package:dio/dio.dart';
import '../model/error_response.dart';

class ApiErrorHandler {
  static String getMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {

        case DioExceptionType.cancel:
          return "Request was cancelled";

        case DioExceptionType.connectionTimeout:
          return "Connection timeout with server";

        case DioExceptionType.sendTimeout:
          return "Send timeout";

        case DioExceptionType.receiveTimeout:
          return "Receive timeout with server";

        case DioExceptionType.badResponse:
          return _handleStatusCode(error);

        case DioExceptionType.connectionError:
          return "No internet connection";

        case DioExceptionType.unknown:
          return "Unexpected error occurred";

        default:
          return "Something went wrong";
      }
    }

    return "Unexpected error occurred";
  }

  static String _handleStatusCode(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    switch (statusCode) {
      case 400:
        return "Bad request";

      case 401:
        return "Unauthorized access";

      case 403:
        return "Forbidden request";

      case 404:
        return "Resource not found";

      case 429:
        return "Too many requests";

      case 500:
      case 503:
        return "Server error. Please try again later";

      default:
        if (data != null) {
          try {
            final errorResponse = ErrorResponse.fromJson(data);

            if (errorResponse.errors != null &&
                errorResponse.errors!.isNotEmpty) {
              return errorResponse.errors!.first.message ?? "Unknown error";
            }

            if (data['message'] != null) {
              return data['message'];
            }

          } catch (_) {
            return "Error parsing server response";
          }
        }

        return "Failed with status code: $statusCode";
    }
  }
}
