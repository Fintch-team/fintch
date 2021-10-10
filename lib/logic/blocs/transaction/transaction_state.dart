import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final bool entity;

  TransactionSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TransactionFailure extends TransactionState {
  final String message;

  TransactionFailure({required this.message});

  @override
  List<Object> get props => [message];
}
