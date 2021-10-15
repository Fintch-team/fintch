import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class MerchantState extends Equatable {
  const MerchantState();
  @override
  List<Object> get props => [];
}

class MerchantInitial extends MerchantState {}

class MerchantLoading extends MerchantState {}

class MerchantSuccess extends MerchantState {
  final ListMerchantEntity entity;

  MerchantSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class MerchantNotFound extends MerchantState {}

class MerchantFailure extends MerchantState {
  final String message;

  MerchantFailure({required this.message});

  @override
  List<Object> get props => [message];
}
