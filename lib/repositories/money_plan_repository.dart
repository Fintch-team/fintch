import 'package:fintch/gen_export.dart';

class MoneyPlanRepository {
  final MoneyPlanService moneyPlanService;
  final LocalAuthService localAuthService;

  MoneyPlanRepository({
    required this.moneyPlanService,
    required this.localAuthService,
  });

  Future<MoneyPlanEntity> getMoneyPlanDetail({required String id}) async {
    MoneyPlanModel moneyPlanModel =
        await moneyPlanService.getMoneyPlanId(id: id);

    return DataMapper.moneyPlanMapper(moneyPlanModel);
  }

  Future<ListMoneyPlanEntity> getMoneyPlan() async {
    ListMoneyPlanModel moneyPlanModel =
        await moneyPlanService.getMoneyPlanAll();

    return DataMapper.listMoneyPlanMapper(moneyPlanModel);
  }

  Future<bool> postMoneyPlan({required MoneyPlanPostEntity postEntity}) async {
    bool res = await moneyPlanService.postMoneyPlan(
      deadline: postEntity.deadline,
      idUser: localAuthService.userId.toString(),
      totalAmount: postEntity.totalAmount,
      name: postEntity.name,
    );

    return res;
  }

  Future<bool> editMoneyPlan({required MoneyPlanPutEntity putEntity}) async {
    bool res = await moneyPlanService.putMoneyPlan(
      idMoneyPlan: putEntity.idMoneyPlan,
      deadline: putEntity.deadline,
      idUser: localAuthService.userId.toString(),
      totalAmount: putEntity.totalAmount.toString(),
      name: putEntity.name,
    );

    return res;
  }

  Future<bool> deleteMoneyPlan({required String idMoneyPlan}) async {
    bool res = await moneyPlanService.deleteMoneyPlan(idMoneyPlan: idMoneyPlan);

    return res;
  }
}
