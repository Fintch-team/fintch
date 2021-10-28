import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class ProfilePayState extends Equatable {
  const ProfilePayState();
  @override
  List<Object> get props => [];
}

class ProfilePayInitial extends ProfilePayState {}

class ProfilePayLoading extends ProfilePayState {}

class ProfilePaySuccess extends ProfilePayState {
  final UserEntity entity;

  ProfilePaySuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class ProfilePayBarcodeSuccess extends ProfilePayState {
  final BarcodeEntity entity;

  ProfilePayBarcodeSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class ProfilePayNotFound extends ProfilePayState {}

class ProfilePayFailure extends ProfilePayState {
  final String message;

  ProfilePayFailure({required this.message});

  @override
  List<Object> get props => [message];
}
