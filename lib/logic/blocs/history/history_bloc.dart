import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;
  final UserRepository userRepository;

  HistoryBloc({required this.historyRepository, required this.userRepository})
      : super(HistoryInitial()) {
    on<GetHistory>((event, emit) async {
      emit(HistoryLoading());
      try {
        HistoryEntity history = await historyRepository.getAllHistory();
        emit(HistoryResponseSuccess(history: history));
      } on FailedException catch (e) {
        emit(HistoryFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HistoryFailure(message: 'unable to get history: $e'));
      }
    });

    on<PostHistory>((event, emit) async {
      emit(HistoryLoading());
      try {
        await historyRepository.postHistory(postEntity: event.entity);
        emit(HistoryRequestSuccess());
      } on FailedException catch (e) {
        emit(HistoryFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HistoryFailure(message: 'unable to get history: $e'));
      }
    });

    on<EditHistory>((event, emit) async {
      emit(HistoryLoading());
      try {
        await historyRepository.editHistory(putEntity: event.entity);
        emit(HistoryRequestSuccess());
      } on FailedException catch (e) {
        emit(HistoryFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HistoryFailure(message: 'unable to get history: $e'));
      }
    });

    on<DeleteHistory>((event, emit) async {
      emit(HistoryLoading());
      try {
        await historyRepository.deleteHistory(idHistory: event.id.toString());
        emit(HistoryRequestSuccess());
      } on FailedException catch (e) {
        emit(HistoryFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HistoryFailure(message: 'unable to get history: $e'));
      }
    });
  }
}
