part of 'auth_bloc.dart';

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
