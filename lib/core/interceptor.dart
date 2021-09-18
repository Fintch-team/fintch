

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FintchInterceptor extends Interceptor {
  final Dio dio;
  FintchInterceptor(this.dio);

  static String csvContentType = 'text/csv; charset=utf-8';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final error = DioError(
        requestOptions: options,
        error: ConnectionErrorException(),
      );
      handler.reject(error);
      return;
    }

    if (options.extra['useAuth'] == false) {
      handler.next(options);
      return;
    }

    dio.lock();
    // final authDataSource = LocalAuthService();
    // String? accessToken = authDataSource.accessToken;
    // if (accessToken != null && authDataSource.isAccessTokenExpired) {
    //   if (authDataSource.isRefreshTokenExpired) {
    //     accessToken = null;
    //   } else {
    //     await authDataSource.refreshAccessToken();
    //     accessToken = authDataSource.accessToken;
    //   }
    // }
    dio.unlock();

    // if (accessToken != null) {
    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // }

    // final LocalConfigService configService = Service.find();
    // if (!options.headers.containsKey('locale')) {
    //   final locale = configService.languageCode;
    //   options.headers['locale'] = locale;
    // }

    // if (!options.headers.containsKey('currency')) {
    //   final currency = configService.currency;
    //   options.headers['currency'] = currency;
    // }

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

    if (response.statusCode == 200) {
      if (response.headers.value('content-type') == csvContentType) {
        handler.next(response);
        return;
      }

      if (response.data['meta'] != null) {
        // final ResponseMeta meta = ResponseMeta.fromJson(response.data['meta']);

        // if (meta.code != 200) {
        //   handler.reject(
        //     DioError(
        //       response: response,
        //       requestOptions: response.requestOptions,
        //       error: meta.message,
        //       type: DioErrorType.response,
        //     ),
        //   );
        //   return;
        // }
      }
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

    if (response.statusCode != 200) {
      if (response.data['detail'] != null) {
        final msg = response.data['detail'];
        handler.reject(
          DioError(
            response: response,
            requestOptions: response.requestOptions,
            error: msg,
          ),
          true,
        );
        return;
      }
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
          content: Builder(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'ERROR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    err.message,
                    style: const TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              );
            },
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    handler.next(err);
  }
}

