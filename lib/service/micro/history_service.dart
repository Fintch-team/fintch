import 'package:fintch/gen_export.dart';

class HistoryService extends ApiService {
  HistoryService() : super('$kUrl/');

  Future<HistoryModel> getHistoryId({
    required String id,
  }) async {
    final res = await dio.get(
      'history/$id',
    );

    return HistoryModel.fromJson(res.data);
  }

  Future<ListHistoryModel> getHistoryAll(
      {String idPay = '', String idReceive = ''}) async {
    Map<String, dynamic> query = {
      if (idPay.isNotEmpty) 'pay': idPay,
      if (idReceive.isNotEmpty) 'receive': idReceive,
    };

    final res = await dio.get('history', queryParameters: query);

    return ListHistoryModel.fromJson(res.data);
  }

  Future<bool> postHistory({
    required String idPay,
    required String idReceive,
    required int amount,
  }) async {
    final res = await dio.post(
      'history',
      data: {
        'id_pay': idPay,
        'id_receive': idReceive,
        'amount': amount,
      },
    );

    return res.statusCode == 201;
  }

  Future<bool> putHistory({
    required String idHistory,
    required String idPay,
    required String idReceive,
    required int amount,
  }) async {
    final res = await dio.put(
      'history/$idHistory',
      data: {
        'id_pay': idPay,
        'id_receive': idReceive,
        'amount': amount,
      },
    );

    return res.statusCode == 200;
  }

  Future<bool> deleteHistory({
    required String idHistory,
  }) async {
    final res = await dio.delete(
      'history/$idHistory',
    );

    return res.statusCode == 204;
  }
}
