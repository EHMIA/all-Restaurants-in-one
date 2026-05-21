import 'package:dio/dio.dart';
import 'package:resturant_project/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});

  static ErrorModel _fromResponse(
    DioException e, {
    String fallback = "An error occurred, please try again",
  }) {
    if (e.response?.data != null) {
      return ErrorModel.fromJson(e.response!.data);
    }
    return ErrorModel(error: fallback);
  }

  static void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(
          errorModel: _fromResponse(e, fallback: "Connection timed out"),
        );
      case DioExceptionType.sendTimeout:
        throw ServerException(
          errorModel: _fromResponse(e, fallback: "Send timed out"),
        );
      case DioExceptionType.receiveTimeout:
        throw ServerException(
          errorModel: _fromResponse(e, fallback: "Response timed out"),
        );
      case DioExceptionType.badCertificate:
        throw ServerException(
          errorModel: _fromResponse(e, fallback: "Bad certificate"),
        );
      case DioExceptionType.cancel:
        throw ServerException(
          errorModel: _fromResponse(e, fallback: "Request was cancelled"),
        );
      case DioExceptionType.connectionError:
        throw ServerException(
          errorModel: _fromResponse(e, fallback: "No internet connection"),
        );
      case DioExceptionType.unknown:
        throw ServerException(
          errorModel: _fromResponse(
            e,
            fallback: "An unexpected error occurred",
          ),
        );
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw ServerException(errorModel: _fromResponse(e));
          case 401:
            throw ServerException(errorModel: _fromResponse(e));
          case 403:
            throw ServerException(errorModel: _fromResponse(e));
          case 404:
            throw ServerException(errorModel: _fromResponse(e));
          case 409:
            throw ServerException(errorModel: _fromResponse(e));
          case 422:
            throw ServerException(errorModel: _fromResponse(e));
          case 500:
            throw ServerException(errorModel: _fromResponse(e));
          case 504:
            throw ServerException(errorModel: _fromResponse(e));
          default:
            throw ServerException(
              errorModel: _fromResponse(e, fallback: "Unexpected server error"),
            );
        }
    }
  }
}
