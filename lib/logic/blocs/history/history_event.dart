import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistory extends HistoryEvent {}

class PostHistory extends HistoryEvent {
  final HistoryPostEntity entity;

  PostHistory({required this.entity});

  @override
  List<Object> get props => [entity];
}

class EditHistory extends HistoryEvent {
  final HistoryPutEntity entity;

  EditHistory({required this.entity});

  @override
  List<Object> get props => [entity];
}

class DeleteHistory extends HistoryEvent {
  final int id;

  DeleteHistory({required this.id});

  @override
  List<Object> get props => [id];
}
