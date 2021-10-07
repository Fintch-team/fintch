import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyManageEvent extends Equatable {
  const MoneyManageEvent();

  @override
  List<Object> get props => [];
}

class GetMoneyManage extends MoneyManageEvent {}

class PostMoneyManage extends MoneyManageEvent {}

class EditMoneyManage extends MoneyManageEvent {}

class DeleteMoneyManage extends MoneyManageEvent {}
