import 'package:bloc/bloc.dart';
import 'package:fintch/data/data.exports.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

class ProfilePayBloc extends Bloc<ProfilePayEvent, ProfilePayState> {
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;
  final BarcodeRepository barcodeRepository;

  ProfilePayBloc(
      {required this.transactionRepository,
      required this.userRepository,
      required this.barcodeRepository})
      : super(ProfilePayInitial()) {
    on<GetReceiveByNickname>((event, emit) async {
      emit(ProfilePayLoading());
      try {
        UserEntity res =
            await userRepository.getByNickname(nickname: event.nickname);
        emit(ProfilePaySuccess(entity: res));
      } on FailedException catch (e) {
        if (e.statusCode == 404) {
          emit(ProfilePayNotFound());
        } else {
          emit(ProfilePayFailure(message: e.message));
        }
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(ProfilePayFailure(
            message: 'unable to get profile user / merchant: $e'));
      }
    });

    on<GetReceiveByBarcode>((event, emit) async {
      emit(ProfilePayLoading());
      try {
        BarcodeEntity res =
            await barcodeRepository.getBarcodeById(id: event.barcode);
        emit(ProfilePayBarcodeSuccess(entity: res));
      } on FailedException catch (e) {
        if (e.statusCode == 404) {
          emit(ProfilePayNotFound());
        } else {
          emit(ProfilePayFailure(message: e.message));
        }
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(ProfilePayFailure(
            message: 'unable to get profile user / merchant: $e'));
      }
    });
  }
}
