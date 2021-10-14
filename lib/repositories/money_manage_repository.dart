import 'package:fintch/gen_export.dart';

class MoneyManageRepository {
  final MoneyManageService moneyManageService;

  MoneyManageRepository({
    required this.moneyManageService,
  });

  Future<MoneyManageEntity> getMoneyManageDetail({required String id}) async {
    MoneyManageModel moneyManageModel =
        await moneyManageService.getMoneyManageId(id: id);

    return DataMapper.moneyManageMapper(moneyManageModel);
  }

  Future<ListMoneyManageEntity> getMoneyManage() async {
    ListMoneyManageModel moneyManageModel =
        await moneyManageService.getMoneyManageAll();

    return DataMapper.listMoneyManageMapper(moneyManageModel);
  }

  Future<MoneyManageIncomeEntity> getMoneyManageIncome() async {
    MoneyManageIncomeModel moneyManageModel =
        await moneyManageService.getMoneyManageIncome();

    return DataMapper.moneyManageIncomeMapper(moneyManageModel);
  }

  Future<bool> inComePostMoneyManage(
      {required MoneyManageInPostEntity postEntity}) async {
    bool res = await moneyManageService.postIncomeMoneyManage(
      name: postEntity.name,
      amount: postEntity.amount,
    );

    return res;
  }

  Future<bool> outComePostMoneyManage(
      {required MoneyManageOutPostEntity postEntity}) async {
    bool res = await moneyManageService.postOutcomeMoneyManage(
        name: postEntity.name,
        amount: postEntity.amount,
        idMoneyManageItem: postEntity.idMoneyManageItem);

    return res;
  }

  Future<bool> editMoneyManage(
      {required MoneyManagePutEntity putEntity}) async {
    bool res = await moneyManageService.putMoneyManage(
      idMoneyManage: putEntity.idMoneyManage,
      name: putEntity.name,
      amount: putEntity.amount,
      idMoneyManageItem: putEntity.idMoneyManageItem,
    );

    return res;
  }

  Future<bool> deleteMoneyManage({required String idMoneyManage}) async {
    bool res = await moneyManageService.deleteMoneyManage(
        idMoneyManage: idMoneyManage);

    return res;
  }
}
