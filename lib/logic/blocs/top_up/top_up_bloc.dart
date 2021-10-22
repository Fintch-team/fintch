import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  final TopUpRepository topUpRepository;

  TopUpBloc({required this.topUpRepository}) : super(TopUpInitial()) {
    on<GetTopUp>((event, emit) async {
      emit(TopUpLoading());
      try {
        ListTopUpEntity entity = await topUpRepository.getTopUp();
        emit(TopUpResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(TopUpFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(TopUpFailure(message: 'unable to get top up: $e'));
      }
    });

    on<DeleteTopUp>((event, emit) async {
      emit(TopUpLoading());
      try {
        await topUpRepository.deleteTopUp(idTopUp: event.id.toString());
        ListTopUpEntity entity = await topUpRepository.getTopUp();

        emit(DeleteTopUpResponseSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(TopUpFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(TopUpFailure(message: 'unable to get top up: $e'));
      }
    });
  }
}
