import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyManageState extends Equatable {
  const MoneyManageState();

  @override
  List<Object> get props => [];
}

class MoneyManageInitial extends MoneyManageState {}

class MoneyManageLoading extends MoneyManageState {}

class MoneyManageRequestSuccess extends MoneyManageState {}

class MoneyManageIncomeSuccess extends MoneyManageState {
  final MoneyManageIncomeEntity entity;

  MoneyManageIncomeSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MoneyManageTabelSuccess extends MoneyManageState {
  final MoneyManageTabelEntity entity;

  MoneyManageTabelSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MoneyManageResponseSuccess extends MoneyManageState {
  final ListMoneyManageEntity entity;

  MoneyManageResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteMoneyManageResponseSuccess extends MoneyManageState {
  final ListMoneyManageEntity entity;

  DeleteMoneyManageResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MoneyManageFailure extends MoneyManageState {
  final String message;

  MoneyManageFailure({required this.message});

  @override
  List<Object> get props => [message];
}
