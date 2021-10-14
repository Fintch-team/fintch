import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class PayState extends Equatable {
  const PayState();

  @override
  List<Object> get props => [];
}

class PayInitial extends PayState {}

class PayLoading extends PayState {}

class PaySuccess extends PayState {
  final bool entity;

  PaySuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PayTopUpSuccess extends PayState {
  final TransactionTopUpEntity entity;

  PayTopUpSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PayFailure extends PayState {
  final String message;

  PayFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class GetReceiveSuccess extends PayState {
  final UserEntity entity;

  GetReceiveSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class GetMerchantSuccess extends PayState {
  final ListMerchantEntity entity;

  GetMerchantSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}
