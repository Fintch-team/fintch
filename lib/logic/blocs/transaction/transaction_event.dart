import 'package:fintch/gen_export.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class PostTransaction extends TransactionEvent {
  final TransactionPostEntity entity;

  PostTransaction({required this.entity});

  @override
  List<Object> get props => [entity];
}

class PostBarcodeTransaction extends TransactionEvent {
  final TransactionBarcodePostEntity entity;

  PostBarcodeTransaction({required this.entity});

  @override
  List<Object> get props => [entity];
}
