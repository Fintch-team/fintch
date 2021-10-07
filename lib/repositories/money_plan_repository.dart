import 'package:fintch/gen_export.dart';

class MoneyPlanRepository {
  final MoneyPlanService moneyPlanService;

  MoneyPlanRepository({
    required this.moneyPlanService,
  });

  Future<MoneyPlanEntity> getPayMoneyPlan({required String id}) async {
    MoneyPlanModel moneyPlanModel =
        await moneyPlanService.getMoneyPlanId(id: id);

    return DataMapper.moneyPlanMapper(moneyPlanModel);
  }

  Future<bool> posttMoneyPlan({required MoneyPlanPostEntity postEntity}) async {
    bool res = await moneyPlanService.postMoneyPlan(
      deadline: postEntity.deadline,
      idUser: postEntity.idUser.toString(),
      totalAmount: postEntity.totalAmount,
    );

    return res;
  }

  Future<bool> editMoneyPlan({required MoneyPlanPutEntity putEntity}) async {
    bool res = await moneyPlanService.putMoneyPlan(
      idMoneyPlan: putEntity.idMoneyPlan,
      deadline: putEntity.deadline,
      idUser: putEntity.idUser.toString(),
      totalAmount: putEntity.totalAmount,
    );

    return res;
  }

  Future<bool> deleteMoneyPlan({required String idMoneyPlan}) async {
    bool res = await moneyPlanService.deleteMoneyPlan(idMoneyPlan: idMoneyPlan);

    return res;
  }
}
