import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';

class MoneyManageService extends ApiService {
  MoneyManageService() : super('$kUrl/');

  Future<MoneyManageModel> getMoneyManageId({
    required String id,
  }) async {
    final res = await dio.get(
      'money-management/$id',
    );

    return MoneyManageModel.fromJson(res.data);
  }

  Future<ListMoneyManageModel> getMoneyManageAll() async {
    final res = await dio.get(
      'money-management',
    );

    return ListMoneyManageModel.fromJson(res.data);
  }

  Future<bool> postIncomeMoneyManage({
    required String name,
    required int amount,
  }) async {
    final res = await dio.post(
      'money-management',
      data: {
        'name': name,
        'amount': amount,
      },
    );

    return res.statusCode == 201;
  }

  Future<bool> postOutcomeMoneyManage({
    required String name,
    required int amount,
    required String idMoneyManageItem,
  }) async {
    final res = await dio.post(
      'money-management',
      data: {
        'name': name,
        'amount': amount,
        'id_money_management_item': idMoneyManageItem
      },
    );

    return res.statusCode == 201;
  }

  Future<bool> putMoneyManage({
    required String idMoneyManage,
    required String name,
    required int amount,
    required String idMoneyManageItem,
  }) async {
    final res = await dio.put(
      'money-management/$idMoneyManage',
      data: {
        'name': name,
        'amount': amount,
        'id_money_management_item': idMoneyManageItem
      },
    );

    return res.statusCode == 200;
  }

  Future<bool> deleteMoneyManage({
    required String idMoneyManage,
  }) async {
    final res = await dio.delete(
      'money-management/$idMoneyManage',
    );

    return res.statusCode == 204;
  }

  Future<MoneyManageItemModel> getMoneyManageItemId({
    required String id,
  }) async {
    final res = await dio.get(
      'money-management-item/$id',
    );

    return MoneyManageItemModel.fromJson(res.data);
  }

  Future<ListMoneyManageItemModel> getMoneyManageItemAll() async {
    final res = await dio.get(
      'money-management-item',
    );

    return ListMoneyManageItemModel.fromJson(res.data);
  }

  Future<bool> postIncomeMoneyManageItem(
      {required String name, required int amount, required int percent}) async {
    final res = await dio.post(
      'money-management-item',
      data: {'name': name, 'amount': amount, 'percent': percent},
    );

    return res.statusCode == 201;
  }

  Future<bool> postOutcomeMoneyManageItem({
    required String name,
    required int amount,
    required int percent,
  }) async {
    final res = await dio.post(
      'money-management-item',
      data: {'name': name, 'amount': amount, 'percent': percent},
    );

    return res.statusCode == 201;
  }

  Future<bool> putMoneyManageItem({
    required String idMoneyManageItem,
    required String name,
    required int amount,
    required int percent,
  }) async {
    final res = await dio.put(
      'money-management-item/$idMoneyManageItem',
      data: {'name': name, 'amount': amount, 'percent': percent},
    );

    return res.statusCode == 200;
  }

  Future<bool> deleteMoneyManageItem({
    required String idMoneyManageItem,
  }) async {
    final res = await dio.delete(
      'money-management-item/$idMoneyManageItem',
    );

    return res.statusCode == 204;
  }
}
