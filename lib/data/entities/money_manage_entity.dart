import 'package:fintch/gen_export.dart';

class MoneyManageInPostEntity extends BaseEntity {
  final String name;
  final String amount;
  final String date;

  MoneyManageInPostEntity({required this.name, required this.amount,required this.date,});
}

class MoneyManageOutPostEntity extends BaseEntity {
  final String name;
  final String amount;
  final String idMoneyManageItem;
  final String date;

  MoneyManageOutPostEntity({
    required this.name,
    required this.amount,
    required this.idMoneyManageItem,
    required this.date,
  });
}

class MoneyManagePutEntity extends BaseEntity {
  final String idMoneyManage;
  final String name;
  final String amount;
  final String idMoneyManageItem;
  final String date;

  MoneyManagePutEntity({
    required this.idMoneyManage,
    required this.name,
    required this.amount,
    required this.idMoneyManageItem,
    required this.date,
  });
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

class MoneyManageIncomeEntity extends BaseEntity {
  final int income;
  final int outcome;

  MoneyManageIncomeEntity({
    required this.income,
    required this.outcome,
  });
}

class MoneyManageTabelEntity extends BaseEntity {
  final Tabel income;
  final Tabel outcome;

  MoneyManageTabelEntity({
    required this.income,
    required this.outcome,
  });
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
  final String percent;

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
  final String percent;

  MoneyManageItemPostEntity({
    required this.name,
    required this.amount,
    required this.percent,
  });
}

class ListMoneyManageEntity extends BaseEntity {
  final List<MoneyManageData> data;

  ListMoneyManageEntity({
    required this.data,
  });
}

class ListMoneyManageItemEntity extends BaseEntity {
  final List<MoneyManageItemData> data;

  ListMoneyManageItemEntity({
    required this.data,
  });
}
