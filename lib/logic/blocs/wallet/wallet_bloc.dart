import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<GetWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        ListWalletEntity entity = await walletRepository.getWallet();

        emit(WalletResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<PostWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        await walletRepository.postWallet(postEntity: event.entity);
        emit(WalletRequestSuccess());
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<EditWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        await walletRepository.editWallet(putEntity: event.entity);
        emit(WalletRequestSuccess());
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<DeleteWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        await walletRepository.deleteWallet(idWallet: event.id.toString());
        emit(WalletRequestSuccess());
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
