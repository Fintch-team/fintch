import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin InComeBloc on Bloc<MoneyManageEvent, MoneyManageState> {}

mixin TabelBloc on Bloc<MoneyManageEvent, MoneyManageState> {}

class MoneyManageBloc extends Bloc<MoneyManageEvent, MoneyManageState>
    with InComeBloc, TabelBloc {
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

    on<PostOutcomeMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.outComePostMoneyManage(
            postEntity: event.entity);
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

    on<EditMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.editMoneyManage(putEntity: event.entity);
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

    on<DeleteMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        await moneyManageRepository.deleteMoneyManage(
            idMoneyManage: event.id.toString());
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

    on<GetIncomeMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        MoneyManageIncomeEntity income =
            await moneyManageRepository.getMoneyManageIncome();

        emit(MoneyManageIncomeSuccess(entity: income));
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<GetTabelMoneyManage>((event, emit) async {
      emit(MoneyManageLoading());
      try {
        MoneyManageTabelEntity income =
            await moneyManageRepository.getMoneyManageTabel();

        emit(MoneyManageTabelSuccess(entity: income));
      } on FailedException catch (e) {
        emit(MoneyManageFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
