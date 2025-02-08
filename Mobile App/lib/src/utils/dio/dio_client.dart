import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio..options.baseUrl = "http://138.197.118.133/";

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('Request URL: ${options.uri.toString()}'); // Print the URL
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle the response
          return handler.next(response);
        },
        onError: (error, handler) {
          // Handle errors
          return handler.next(error);
        },
      ),
    );
  }

  Future<Either> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } catch (e) {
      return Left(Exception('Error: $e'));
    }
  }
}
