import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin AuthPinBloc on Bloc<PayEvent, PayState> {}

class PayBloc extends Bloc<PayEvent, PayState> with AuthPinBloc {
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;

  PayBloc({required this.transactionRepository, required this.userRepository})
      : super(PayInitial()) {
    on<AuthPin>((event, emit) async {
      emit(AuthPinLoading());
      try {
        bool res =
            await userRepository.authWithPin(authPostEntity: event.entity);
        emit(PaySuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to auth Pin: $e'));
      }
    });

    on<PostPay>((event, emit) async {
      emit(PayLoading());
      try {
        bool res = await transactionRepository.postTransaction(
            postEntity: event.entity);
        emit(PaySuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to Transaction: $e'));
      }
    });

    on<PostBarcodePay>((event, emit) async {
      emit(PayLoading());
      try {
        bool res = await transactionRepository.postTransactionBarcode(
            postEntity: event.entity);
        emit(PaySuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to Barcode Pay: $e'));
      }
    });

    on<PostTopUpPay>((event, emit) async {
      emit(PayLoading());
      try {
        TransactionTopUpEntity res = await transactionRepository
            .postTransactionTopUp(postEntity: event.entity);
        emit(PayTopUpSuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to top up pay: $e'));
      }
    });
  }
}
