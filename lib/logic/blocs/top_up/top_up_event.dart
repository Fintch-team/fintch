import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class TopUpEvent extends Equatable {
  const TopUpEvent();

  @override
  List<Object> get props => [];
}

class GetTopUp extends TopUpEvent {}

class DeleteTopUp extends TopUpEvent {
  final int id;

  DeleteTopUp({required this.id});

  @override
  List<Object> get props => [id];
}
