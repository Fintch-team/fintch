import 'package:bloc/bloc.dart';

import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc({required this.transactionRepository})
      : super(TransactionInitial()) {
    on<PostTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        bool res = await transactionRepository.postTransaction(
            postEntity: event.entity);
        emit(TransactionSuccess(entity: res));
      } on FailedException catch (e) {
        emit(TransactionFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(TransactionFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<PostBarcodeTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        bool res = await transactionRepository.postTransactionBarcode(
            postEntity: event.entity);
        emit(TransactionSuccess(entity: res));
      } on FailedException catch (e) {
        emit(TransactionFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(TransactionFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
