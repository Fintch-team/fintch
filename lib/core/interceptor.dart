import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FintchInterceptor extends Interceptor {
  final Dio dio;
  FintchInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final error = DioError(
        requestOptions: options,
        error: FailedException('Connection Error'),
      );
      handler.reject(error);
      return;
    }

    if (options.extra['useAuth'] == false) {
      handler.next(options);
      return;
    }

    dio.lock();
    final authDataSource = LocalAuthService();
    String? accessToken = authDataSource.token;
    // if (accessToken != null && authDataSource.isAccessTokenExpired) {
    //   if (authDataSource.isRefreshTokenExpired) {
    //     accessToken = null;
    //   } else {
    //     await authDataSource.refreshAccessToken();
    //     accessToken = authDataSource.accessToken;
    //   }
    // }
    dio.unlock();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.data is ResponseBody) {
      handler.next(response);
      return;
    }

    if (response.statusCode == 307 || response.statusCode == 404) {
      debugPrint(response.requestOptions.uri.toString());
      handler.reject(
        DioError(
          response: response,
          requestOptions: response.requestOptions,
          error: response.statusMessage,
        ),
        true,
      );
      return;
    }

    if (response.statusCode == 422) {
      if (response.data['details'] != null) {
        // final msg = response.data['details'];
        handler.reject(
          DioError(
            response: response,
            requestOptions: response.requestOptions,
            // error: ValidationErrorException(msg),
            error: FailedException(response.data['message']),
          ),
          true,
        );
        return;
      }
    }

    if (response.statusCode == 401) {
      final error = DioError(
        requestOptions: response.requestOptions,
        error: FailedException(response.data['message']),
      );
      handler.reject(error);
      return;
    }

    if (response.statusCode == 406) {
      final error = DioError(
        requestOptions: response.requestOptions,
        error: FailedException(response.data['message']),
      );
      handler.reject(error);
      return;
    }

    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!kDebugMode) {
      await FirebaseCrashlytics.instance.recordError(
        err.error,
        err.stackTrace,
        reason: err.message + '\n URL: ${err.requestOptions.uri}',
        printDetails: true,
      );
    }

    if (!isProduction) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Column(
            children: [
              const Text(
                'ERROR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Text(err.message, style: AppTheme.text1),
            ],
          ),
          backgroundColor: AppTheme.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Column(
            children: [
              const Text(
                'ERROR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Text(err.message, style: AppTheme.text1),
            ],
          ),
          backgroundColor: AppTheme.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    handler.next(err);
  }
}
