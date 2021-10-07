import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyManageState extends Equatable {
  const MoneyManageState();

  @override
  List<Object> get props => [];
}

class MoneyManageInitial extends MoneyManageState {}

class MoneyManageLoading extends MoneyManageState {}

class MoneyManageSuccess extends MoneyManageState {
  final UserEntity entity;

  MoneyManageSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MoneyManageFailure extends MoneyManageState {
  final String message;

  MoneyManageFailure({required this.message});

  @override
  List<Object> get props => [message];
}
