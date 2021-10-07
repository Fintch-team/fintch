import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MoneyPlanEvent extends Equatable {
  const MoneyPlanEvent();

  @override
  List<Object> get props => [];
}

class GetMoneyPlan extends MoneyPlanEvent {}

class PostMoneyPlan extends MoneyPlanEvent {}

class EditMoneyPlan extends MoneyPlanEvent {}

class DeleteMoneyPlan extends MoneyPlanEvent {}
