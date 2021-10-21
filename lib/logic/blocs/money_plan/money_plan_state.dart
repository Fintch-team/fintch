import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyPlanState extends Equatable {
  const MoneyPlanState();

  @override
  List<Object> get props => [];
}

class MoneyPlanInitial extends MoneyPlanState {}

class MoneyPlanLoading extends MoneyPlanState {}

class MoneyPlanRequestSuccess extends MoneyPlanState {}

class MoneyPlanResponseSuccess extends MoneyPlanState {
  final ListMoneyPlanEntity entity;

  MoneyPlanResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteMoneyPlanResponseSuccess extends MoneyPlanState {
  final ListMoneyPlanEntity entity;

  DeleteMoneyPlanResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MoneyPlanFailure extends MoneyPlanState {
  final String message;

  MoneyPlanFailure({required this.message});

  @override
  List<Object> get props => [message];
}
