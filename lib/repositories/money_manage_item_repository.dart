import 'package:fintch/gen_export.dart';

class MoneyManageItemRepository {
  final LocalAuthService localAuthService;
  final MoneyManageService moneyManageItemService;

  MoneyManageItemRepository({
    required this.moneyManageItemService,
    required this.localAuthService,
  });

  Future<MoneyManageItemEntity> getMoneyManageItemDetail(
      {required String id}) async {
    MoneyManageItemModel moneyManageItemModel =
        await moneyManageItemService.getMoneyManageItemId(id: id);

    return DataMapper.moneyManageItemMapper(moneyManageItemModel);
  }

  Future<ListMoneyManageItemEntity> getMoneyManageItem() async {
    ListMoneyManageItemModel moneyManageItemModel =
        await moneyManageItemService.getMoneyManageItemAll();

    return DataMapper.listMoneyManageItemMapper(moneyManageItemModel);
  }

  Future<bool> postMoneyManageItem(
      {required MoneyManageItemPostEntity postEntity}) async {
    bool res = await moneyManageItemService.postMoneyManageItem(
      name: postEntity.name,
      amount: postEntity.amount,
      percent: postEntity.percent,
      idUser: localAuthService.userId,
    );

    return res;
  }

  Future<bool> editMoneyManageItem(
      {required MoneyManageItemPutEntity putEntity}) async {
    bool res = await moneyManageItemService.putMoneyManageItem(
      idMoneyManageItem: putEntity.idMoneyManageItem,
      name: putEntity.name,
      amount: putEntity.amount,
      percent: putEntity.percent,
      idUser: localAuthService.userId,
    );

    return res;
  }

  Future<bool> deleteMoneyManageItem(
      {required String idMoneyManageItem}) async {
    bool res = await moneyManageItemService.deleteMoneyManageItem(
        idMoneyManageItem: idMoneyManageItem);

    return res;
  }
}
