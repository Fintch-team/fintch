import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletRequestSuccess extends WalletState {}

class WalletResponseSuccess extends WalletState {
  final WalletEntity entity;

  WalletResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteBarrierCashSuccess extends WalletState {
  final WalletEntity entity;

  DeleteBarrierCashSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class WalletFailure extends WalletState {
  final String message;

  WalletFailure({required this.message});

  @override
  List<Object> get props => [message];
}
