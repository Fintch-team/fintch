import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin MoneyManageItemSheetBloc
    on Bloc<MoneyManageItemEvent, MoneyManageItemState> {}

class MoneyManageItemBloc
    extends Bloc<MoneyManageItemEvent, MoneyManageItemState>
    implements MoneyManageItemSheetBloc {
  final MoneyManageItemRepository moneyManageItemRepository;

  MoneyManageItemBloc({required this.moneyManageItemRepository})
      : super(MoneyManageItemInitial()) {
    on<GetMoneyManageItem>((event, emit) async {
      emit(MoneyManageItemLoading());
      try {
        ListMoneyManageItemEntity entity =
            await moneyManageItemRepository.getMoneyManageItem();

        emit(MoneyManageItemResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyManageItemFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageItemFailure(message: 'unable to get money item: $e'));
      }
    });

    on<PostMoneyManageItem>((event, emit) async {
      emit(MoneyManageItemLoading());
      try {
        await moneyManageItemRepository.postMoneyManageItem(
            postEntity: event.entity);
        ListMoneyManageItemEntity entity =
            await moneyManageItemRepository.getMoneyManageItem();

        emit(MoneyManageItemResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyManageItemFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageItemFailure(message: 'unable to get money item: $e'));
      }
    });

    on<EditMoneyManageItem>((event, emit) async {
      emit(MoneyManageItemLoading());
      try {
        await moneyManageItemRepository.editMoneyManageItem(
            putEntity: event.entity);
        ListMoneyManageItemEntity entity =
            await moneyManageItemRepository.getMoneyManageItem();

        emit(MoneyManageItemResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyManageItemFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageItemFailure(message: 'unable to get money item: $e'));
      }
    });

    on<DeleteMoneyManageItem>((event, emit) async {
      emit(MoneyManageItemLoading());
      try {
        await moneyManageItemRepository.deleteMoneyManageItem(
            idMoneyManageItem: event.id.toString());
        ListMoneyManageItemEntity entity =
            await moneyManageItemRepository.getMoneyManageItem();

        emit(DeleteMoneyManageItemResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(MoneyManageItemFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MoneyManageItemFailure(message: 'unable to get money item: $e'));
      }
    });
  }
}
