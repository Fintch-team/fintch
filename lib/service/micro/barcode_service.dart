import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';

class BarcodeService extends ApiService {
  BarcodeService() : super('$kUrl/');

  Future<BarcodeModel> getBarcodeId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'barcode/$id',
      );

      return BarcodeModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListBarcodeModel> getBarcodeAll(
      {String idPay = '', String idReceive = ''}) async {
    try {
      final res = await dio.get(
        'barcode',
      );

      return ListBarcodeModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postBarcode({
    required String name,
    required String confirm,
    required String amount,
    required String idUser,
  }) async {
    try {
      final res = await dio.post(
        'barcode',
        data: {
          'name': name,
          'confirm': confirm,
          'amount': amount,
          'id_user': idUser,
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putBarcode({
    required String idBarcode,
    required String name,
    required String confirm,
    required String amount,
    required String idUser,
  }) async {
    try {
      final res = await dio.put(
        'barcode/$idBarcode',
        data: {
          'name': name,
          'confirm': confirm,
          'amount': amount,
          'id_user': idUser,
        },
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteBarcode({
    required String idBarcode,
  }) async {
    try {
      final res = await dio.delete(
        'barcode/$idBarcode',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
