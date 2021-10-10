import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyManageItemEvent extends Equatable {
  const MoneyManageItemEvent();

  @override
  List<Object> get props => [];
}

class GetMoneyManageItem extends MoneyManageItemEvent {}

class PostIncomeMoneyManageItem extends MoneyManageItemEvent {
  final MoneyManageItemPostEntity entity;

  PostIncomeMoneyManageItem({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PostMoneyManageItem extends MoneyManageItemEvent {
  final MoneyManageItemPostEntity entity;

  PostMoneyManageItem({required this.entity});

  @override
  List<Object> get props => [entity];
}

class EditMoneyManageItem extends MoneyManageItemEvent {
  final MoneyManageItemPutEntity entity;

  EditMoneyManageItem({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteMoneyManageItem extends MoneyManageItemEvent {
  final int id;

  DeleteMoneyManageItem({required this.id});

  @override
  List<Object> get props => [id];
}
