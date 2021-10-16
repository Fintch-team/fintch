import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class PostAuth extends AuthEvent {
  final AuthPostEntity entity;

  PostAuth({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class GetIsLoggedIn extends AuthEvent {}

class ChangePin extends AuthEvent {
  final PostChangePinEntity entity;

  ChangePin({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class ChangePassword extends AuthEvent {
  final PostChangePasswordEntity entity;

  ChangePassword({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class AuthPin extends AuthEvent {
  final AuthPinPostEntity entity;

  AuthPin({required this.entity});

  @override
  List<Object> get props => [entity];
}

class Logout extends AuthEvent {}
