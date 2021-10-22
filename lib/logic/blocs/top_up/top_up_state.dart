import 'package:fintch/gen_export.dart';
import 'package:equatable/equatable.dart';

abstract class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object> get props => [];
}

class TopUpInitial extends TopUpState {}

class TopUpLoading extends TopUpState {}

class TopUpRequestSuccess extends TopUpState {}

class TopUpResponseSuccess extends TopUpState {
  final ListTopUpEntity entity;

  TopUpResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteTopUpResponseSuccess extends TopUpState {
  final ListTopUpEntity entity;

  DeleteTopUpResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TopUpFailure extends TopUpState {
  final String message;

  TopUpFailure({required this.message});

  @override
  List<Object> get props => [message];
}
