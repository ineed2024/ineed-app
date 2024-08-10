// ignore_for_file: prefer_if_null_operators

import 'package:dio/dio.dart';

import 'interceptors/auth_interceptor.dart';

class CustomDio {
  final Dio _dio;
  final AuthInterceptor _authInterceptor;

  CustomDio(this._dio, this._authInterceptor) {
    _dio.options.connectTimeout = const Duration(minutes: 3);
    _dio.options.sendTimeout = const Duration(minutes: 3);
    _dio.options.receiveTimeout = const Duration(minutes: 3);

    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(LogInterceptor(
        requestBody: true, responseBody: true, requestHeader: true));
    _dio.options.headers['Device'] = '1';

    // _dio.options.baseUrl =
    //     // "http://ineed.eba-kamyusxw.us-east-2.elasticbeanstalk.com/api/";
    _dio.options.baseUrl = "http://3.140.170.217:3000/api/";
  }

  Future<T> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
  }) async {
    final res = await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        extra: extra,
      ),
    );
    return res.data!;
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    onReceiveProgress,
  }) async {
    final res = await _dio.get<T>(
      path,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        extra: extra,
      ),
    );
    return res.data!;
  }

  Future<T> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    onSendProgress,
    onReceiveProgress,
  }) async {
    final res = await _dio.patch<T>(
      path,
      data: data,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        extra: extra,
      ),
    );
    return res.data!;
  }

  Future<T> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    onSendProgress,
    onReceiveProgress,
    contentType,
  }) async {
    final res = await _dio.post<T>(
      path,
      data: data,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      options: Options(
          headers: headers,
          extra: extra,
          contentType:
              contentType != null ? contentType : Headers.jsonContentType),
    );
    return res.data!;
  }

  Future<T> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    onSendProgress,
    onReceiveProgress,
  }) async {
    final res = await _dio.put<T>(
      path,
      data: data,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        extra: extra,
      ),
    );
    return res.data!;
  }

  Future<T> download<T>(
    String url,
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    deleteOnError,
    onReceiveProgress,
    cancelToken,
  }) async {
    final res = await _dio.download(
      url,
      path,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      options: Options(
        headers: headers,
        extra: extra,
        receiveTimeout: const Duration(minutes: 3),
      ),
    );
    return res.data!;
  }
}
