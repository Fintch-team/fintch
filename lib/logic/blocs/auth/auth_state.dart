import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthEntity entity;

  AuthSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthIsLoggedIn extends AuthState {
  final bool isLoggedIn;

  AuthIsLoggedIn({required this.isLoggedIn});

  @override
  List<Object> get props => [isLoggedIn];
}

class AuthPinFetched extends AuthState {
  final bool isCorrect;

  AuthPinFetched({required this.isCorrect});

  @override
  List<Object> get props => [isCorrect];
}

class ChangeSuccess extends AuthState {}
