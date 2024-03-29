import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class PayEvent extends Equatable {
  const PayEvent();

  @override
  List<Object> get props => [];
}

class PostPay extends PayEvent {
  final TransactionPostEntity entity;

  PostPay({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PostBarcodePay extends PayEvent {
  final TransactionBarcodePostEntity entity;

  PostBarcodePay({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PostTopUpPay extends PayEvent {
  final TransactionTopUpPostEntity entity;

  PostTopUpPay({required this.entity});

  @override
  List<Object> get props => [entity];
}
