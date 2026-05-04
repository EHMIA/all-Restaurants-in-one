import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:dio/dio.dart';
import 'package:resturant_project/core/api/api_interceptors.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/core/errors/exceptions.dart';

// class DioConsumer extends ApiConsumer {
//   final Dio dio;
//   DioConsumer({required this.dio}){

//     dio.options.baseUrl=EndPoints.baseUrl;
//     dio.interceptors.add(ApiInterceptors());
//     dio.interceptors.add(LogInterceptor(
//       request: true,
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: true,
//       error: true,
//     ));
//   }
class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio, String? token}) {
    dio.options.baseUrl = EndPoints.baseUrl;

    dio.interceptors.add(ApiInterceptors());

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }
  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      print('STATUS CODE: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }
}
