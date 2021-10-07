import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryResponseSuccess extends HistoryState {
  final HistoryEntity pay;
  final HistoryEntity receive;

  HistoryResponseSuccess({required this.pay, required this.receive});

  @override
  List<Object> get props => [pay, receive];
}

class HistoryRequestSuccess extends HistoryState {}

class HistoryFailure extends HistoryState {
  final String message;

  HistoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
