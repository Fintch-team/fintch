import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<HistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
