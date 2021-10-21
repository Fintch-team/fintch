import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin MoneyPlanSheetBloc on Bloc<MoneyPlanEvent, MoneyPlanState>{}

class MoneyPlanBloc extends Bloc<MoneyPlanEvent, MoneyPlanState> implements MoneyPlanSheetBloc{
  final MoneyPlanRepository moneyPlanRepository;

  MoneyPlanBloc({required this.moneyPlanRepository})
      : super(MoneyPlanInitial()) {
    on<GetMoneyPlan>((event, emit) async {
      emit(MoneyPlanLoading());
      try {
        ListMoneyPlanEntity entity = await moneyPlanRepository.getMoneyPlan();
        emit(MoneyPlanResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyPlanFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyPlanFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<PostMoneyPlan>((event, emit) async {
      emit(MoneyPlanLoading());
      try {
        await moneyPlanRepository.postMoneyPlan(postEntity: event.entity);
        ListMoneyPlanEntity entity = await moneyPlanRepository.getMoneyPlan();

        emit(MoneyPlanResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyPlanFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyPlanFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<EditMoneyPlan>((event, emit) async {
      emit(MoneyPlanLoading());
      try {
        await moneyPlanRepository.editMoneyPlan(putEntity: event.entity);
        ListMoneyPlanEntity entity = await moneyPlanRepository.getMoneyPlan();

        emit(MoneyPlanResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyPlanFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyPlanFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<DeleteMoneyPlan>((event, emit) async {
      emit(MoneyPlanLoading());
      try {
        await moneyPlanRepository.deleteMoneyPlan(
            idMoneyPlan: event.id.toString());
        ListMoneyPlanEntity entity = await moneyPlanRepository.getMoneyPlan();

        emit(DeleteMoneyPlanResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyPlanFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyPlanFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
