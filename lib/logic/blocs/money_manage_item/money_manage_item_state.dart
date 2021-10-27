import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyManageItemState extends Equatable {
  const MoneyManageItemState();

  @override
  List<Object> get props => [];
}

class MoneyManageItemInitial extends MoneyManageItemState {}

class MoneyManageItemLoading extends MoneyManageItemState {}

class MoneyManageItemRequestSuccess extends MoneyManageItemState {}

class MoneyManageItemResponseSuccess extends MoneyManageItemState {
  final ListMoneyManageItemEntity entity;

  MoneyManageItemResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteMoneyManageItemResponseSuccess extends MoneyManageItemState {
  final ListMoneyManageItemEntity entity;

  DeleteMoneyManageItemResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MoneyManageItemFailure extends MoneyManageItemState {
  final String message;

  MoneyManageItemFailure({required this.message});

  @override
  List<Object> get props => [message];
}
