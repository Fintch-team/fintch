import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class BarcodeState extends Equatable {
  const BarcodeState();

  @override
  List<Object> get props => [];
}

class BarcodeInitial extends BarcodeState {}

class BarcodeLoading extends BarcodeState {}

class BarcodeResponseSuccess extends BarcodeState {
  final ListBarcodeEntity entity;

  BarcodeResponseSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class BarcodeRequestSuccess extends BarcodeState {}

class BarcodeFailure extends BarcodeState {
  final String message;

  BarcodeFailure({required this.message});

  @override
  List<Object> get props => [message];
}
