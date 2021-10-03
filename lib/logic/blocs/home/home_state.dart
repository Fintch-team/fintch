import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final UserEntity entity;

  HomeSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}
