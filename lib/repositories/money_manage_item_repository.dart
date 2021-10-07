import 'package:fintch/gen_export.dart';

class MoneyManageItemRepository {
  final MoneyManageService moneyManageItemService;

  MoneyManageItemRepository({
    required this.moneyManageItemService,
  });

  Future<MoneyManageItemEntity> getPayMoneyManageItem(
      {required String id}) async {
    MoneyManageItemModel moneyManageItemModel =
        await moneyManageItemService.getMoneyManageItemId(id: id);

    return DataMapper.moneyManageItemMapper(moneyManageItemModel);
  }

  Future<bool> posttMoneyManageItem(
      {required MoneyManageItemPostEntity postEntity}) async {
    bool res = await moneyManageItemService.postMoneyManageItem(
      name: postEntity.name,
      amount: postEntity.amount,
      percent: postEntity.percent,
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
