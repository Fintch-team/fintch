import 'package:fintch/gen_export.dart';

class MoneyManageInPostEntity extends BaseEntity {
  final String name;
  final int amount;

  MoneyManageInPostEntity({required this.name, required this.amount});
}

class MoneyManageOutPostEntity extends BaseEntity {
  final String name;
  final int amount;
  final String idMoneyManageItem;

  MoneyManageOutPostEntity(
      {required this.name,
      required this.amount,
      required this.idMoneyManageItem});
}

class MoneyManagePutEntity extends BaseEntity {
  final String idMoneyManage;
  final String name;
  final int amount;
  final String idMoneyManageItem;

  MoneyManagePutEntity(
      {required this.idMoneyManage,
      required this.name,
      required this.amount,
      required this.idMoneyManageItem});
}

class MoneyManageEntity extends BaseEntity {
  final int id;
  final String name;
  final int amount;
  final bool isIncome;
  final MoneyManageItemData item;

  MoneyManageEntity(
      {required this.id,
      required this.name,
      required this.amount,
      required this.isIncome,
      required this.item});
}

class MoneyManageItemEntity extends BaseEntity {
  final int id;
  final String name;
  final int amount;
  final int percent;

  MoneyManageItemEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.percent,
  });
}

class MoneyManageItemPutEntity extends BaseEntity {
  final String idMoneyManageItem;
  final String name;
  final int amount;
  final int percent;

  MoneyManageItemPutEntity({
    required this.name,
    required this.amount,
    required this.idMoneyManageItem,
    required this.percent,
  });
}

class MoneyManageItemPostEntity extends BaseEntity {
  final String name;
  final int amount;
  final int percent;

  MoneyManageItemPostEntity({
    required this.name,
    required this.amount,
    required this.percent,
  });
}
