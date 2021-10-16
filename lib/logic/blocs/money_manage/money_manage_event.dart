import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyManageEvent extends Equatable {
  const MoneyManageEvent();

  @override
  List<Object> get props => [];
}

class GetMoneyManage extends MoneyManageEvent {}

class GetIncomeMoneyManage extends MoneyManageEvent {}

class GetTabelMoneyManage extends MoneyManageEvent {}

class PostIncomeMoneyManage extends MoneyManageEvent {
  final MoneyManageInPostEntity entity;

  PostIncomeMoneyManage({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PostOutcomeMoneyManage extends MoneyManageEvent {
  final MoneyManageOutPostEntity entity;

  PostOutcomeMoneyManage({required this.entity});

  @override
  List<Object> get props => [entity];
}

class EditMoneyManage extends MoneyManageEvent {
  final MoneyManagePutEntity entity;

  EditMoneyManage({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteMoneyManage extends MoneyManageEvent {
  final int id;

  DeleteMoneyManage({required this.id});

  @override
  List<Object> get props => [id];
}
