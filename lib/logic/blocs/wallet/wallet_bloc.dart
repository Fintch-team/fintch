import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<GetWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        WalletEntity entity = await walletRepository.getWalletDetail();

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
        WalletEntity entity = await walletRepository.getWalletDetail();

        emit(WalletResponseSuccess(entity: entity));
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
        WalletEntity entity = await walletRepository.getWalletDetail();

        emit(WalletResponseSuccess(entity: entity));
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
        WalletEntity entity = await walletRepository.getWalletDetail();

        emit(WalletResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<DeleteBarrierCash>((event, emit) async {
      emit(WalletLoading());
      try {
        await walletRepository.deleteBarrierCash();
        WalletEntity entity = await walletRepository.getWalletDetail();

        emit(WalletResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<ExtendBarrierCash>((event, emit) async {
      emit(WalletLoading());
      try {
        await walletRepository.extendBarrierCash();
        WalletEntity entity = await walletRepository.getWalletDetail();

        emit(WalletResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });

    on<AddBarrierCash>((event, emit) async {
      emit(WalletLoading());
      try {
        await walletRepository.postBarrierExpired(entity: event.entity);
        WalletEntity entity = await walletRepository.getWalletDetail();

        emit(WalletResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(WalletFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(WalletFailure(message: 'unable to get moneyPlan: $e'));
      }
    });
  }
}
