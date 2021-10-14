import 'package:bloc/bloc.dart';

import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;

  PayBloc({required this.transactionRepository, required this.userRepository})
      : super(PayInitial()) {
    on<AuthPin>((event, emit) async {
      emit(PayLoading());
      try {
        bool res =
            await userRepository.authWithPin(authPostEntity: event.entity);
        emit(PaySuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<GetMerchant>((event, emit) async {
      emit(PayLoading());
      try {
        ListMerchantEntity res = await userRepository.getMerchant();
        emit(GetMerchantSuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<GetReceive>((event, emit) async {
      emit(PayLoading());
      try {
        UserEntity res =
            await userRepository.getByNickname(nickname: event.entity);
        emit(GetReceiveSuccess(entity: res));
      } on FailedException catch (e) {
        emit(PayFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(PayFailure(message: 'unable to get moneyPlan: $e'));
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
        emit(PayFailure(message: 'unable to get moneyPlan: $e'));
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
        emit(PayFailure(message: 'unable to get moneyPlan: $e'));
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
        emit(PayFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
