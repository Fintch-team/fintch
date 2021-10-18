import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class BarcodeEvent extends Equatable {
  const BarcodeEvent();

  @override
  List<Object> get props => [];
}

class GetBarcode extends BarcodeEvent {}

class PostBarcode extends BarcodeEvent {
  final BarcodePostEntity entity;

  PostBarcode({required this.entity});

  @override
  List<Object> get props => [entity];
}

class EditBarcode extends BarcodeEvent {
  final BarcodePutEntity entity;

  EditBarcode({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteBarcode extends BarcodeEvent {
  final int id;

  DeleteBarcode({required this.id});

  @override
  List<Object> get props => [id];
}
