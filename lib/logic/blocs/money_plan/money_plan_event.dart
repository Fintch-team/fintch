import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyPlanEvent extends Equatable {
  const MoneyPlanEvent();

  @override
  List<Object> get props => [];
}

class GetMoneyPlan extends MoneyPlanEvent {}

class PostMoneyPlan extends MoneyPlanEvent {
  final MoneyPlanPostEntity entity;

  PostMoneyPlan({required this.entity});

  @override
  List<Object> get props => [entity];
}

class EditMoneyPlan extends MoneyPlanEvent {
  final MoneyPlanPutEntity entity;

  EditMoneyPlan({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteMoneyPlan extends MoneyPlanEvent {
  final int id;

  DeleteMoneyPlan({required this.id});

  @override
  List<Object> get props => [id];
}
