import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class MoneyManageBloc extends Bloc<MoneyManageEvent, MoneyManageState> {
  final MoneyManageRepository moneyManageRepository;

  MoneyManageBloc({required this.moneyManageRepository})
      : super(MoneyManageInitial()) {
    on<GetMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        ListMoneyManageEntity entity =
            await moneyManageRepository.getMoneyManage();

        emit(MoneyManageResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<PostIncomeMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.inComePostMoneyManage(
            postEntity: event.entity);
        emit(MoneyManageRequestSuccess());
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<PostOutcomeMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.outComePostMoneyManage(
            postEntity: event.entity);
        emit(MoneyManageRequestSuccess());
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<EditMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.editMoneyManage(putEntity: event.entity);
        emit(MoneyManageRequestSuccess());
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<DeleteMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.deleteMoneyManage(
            idMoneyManage: event.id.toString());
        emit(MoneyManageRequestSuccess());
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
