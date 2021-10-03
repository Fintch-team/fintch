import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:fintch/gen_export.dart';
// import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';

import 'services.dart';

abstract class ApiService implements Service {
  final String _base;
  final HttpService _dio;

  ApiService(String url)
      : _base = url + (url.endsWith('/') ? '' : '/'),
        _dio = HttpService(url + (url.endsWith('/') ? '' : '/'));

  String get baseUrl => _base;
  HttpService get dio => _dio;

  @override
  void dispose() {}
}

dynamic _jsonDecodeCallback(String text) async {
  return await compute(_jsonDecode, text);
}

dynamic _jsonDecode(String data) {
  return jsonDecode(data);
}

class SignatureTransformer extends DefaultTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    final res = await super.transformRequest(options);
    options.headers['x-signature'] = res.length;
    return res;
  }
}

class HttpService extends DioForNative {
  HttpService._([BaseOptions? options]) : super(options) {
    interceptors.add(FintchInterceptor(this));
    // interceptors.add(ThrottleInterceptor());
    // interceptors.add(DioFirebasePerformanceInterceptor());
    // interceptors.add(DeviceInfoInterceptor());

    transformer = SignatureTransformer();
  }

  factory HttpService([String baseUrl = '']) {
    final result = HttpService._(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
        },
        baseUrl: baseUrl,
        contentType: 'application/json',
        responseType: ResponseType.json,
        validateStatus: (statusCode) => statusCode! < 500,
        receiveDataWhenStatusError: true,
        followRedirects: true,
        setRequestContentTypeWhenNoPayload: true,
        connectTimeout: 5 * 1000,
        receiveTimeout: 30 * 1000,
        sendTimeout: 30 * 1000,
      ),
    );

    if (!kDebugMode) {
      (result.transformer as DefaultTransformer).jsonDecodeCallback =
          _jsonDecodeCallback;
    }

    return result;
  }

  final _completers = <_HttpRequest, dynamic>{};

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (options?.extra?['force'] ?? false) {
      return retry(
        () => super.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
        ),
        retryIf: (e) =>
            e is DioError &&
            [
              DioErrorType.connectTimeout,
              DioErrorType.receiveTimeout,
              DioErrorType.sendTimeout
            ].contains(e.type),
      );
    }

    final request = _HttpRequest(
      path: path,
      queryParameters: queryParameters,
      headers: options?.headers,
    );

    if (_completers.containsKey(request)) {
      return _completers[request]!.future;
    }

    final completer = Completer<Response<T>>();
    retry(
      () => super.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
      retryIf: (e) =>
          e is DioError &&
          [
            DioErrorType.connectTimeout,
            DioErrorType.receiveTimeout,
            DioErrorType.sendTimeout,
          ].contains(e.type),
    ).then(
      (value) {
        completer.complete(value);
        Future.delayed(const Duration(seconds: 5), () {
          _completers.remove(request);
        });
      },
    ).onError(
      (error, stackTrace) {
        completer.completeError(error!, stackTrace);
      },
    );

    _completers[request] = completer;
    return completer.future;
  }
}

class _HttpRequest {
  final String path;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;

  _HttpRequest({
    required this.path,
    this.queryParameters,
    this.headers,
  });

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is _HttpRequest &&
          other.path == path &&
          other.queryParameters == queryParameters &&
          other.headers == headers;

  @override
  int get hashCode => hashList([
        path,
        queryParameters,
        headers,
      ]);
}
