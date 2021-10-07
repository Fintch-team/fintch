import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class PostWallet extends WalletEvent {
  final WalletPostEntity entity;

  PostWallet({required this.entity});

  @override
  List<Object> get props => [entity];
}

class EditWallet extends WalletEvent {
  final WalletPutEntity entity;

  EditWallet({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteWallet extends WalletEvent {
  final int id;

  DeleteWallet({required this.id});

  @override
  List<Object> get props => [id];
}
