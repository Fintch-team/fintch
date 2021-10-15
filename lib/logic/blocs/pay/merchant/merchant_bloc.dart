import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final UserRepository userRepository;
  MerchantBloc({required this.userRepository}) : super(MerchantInitial()) {
    on<GetMerchants>((event, emit) async {
      emit(MerchantLoading());
      try {
        ListMerchantEntity res = await userRepository.getMerchant();
        emit(MerchantSuccess(entity: res));
      } on FailedException catch (e) {
        emit(MerchantFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(MerchantFailure(message: 'unable to get merchant: $e'));
      }
    });
  }
}
