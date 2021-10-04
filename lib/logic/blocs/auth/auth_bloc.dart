import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

mixin PinBloc on Bloc<AuthEvent, AuthState> {}

mixin PasswordBloc on Bloc<AuthEvent, AuthState> {}

class AuthBloc extends Bloc<AuthEvent, AuthState> with PinBloc, PasswordBloc {
  final UserRepository userRepository;

  AuthBloc({
    required this.userRepository,
  }) : super(AuthInitial()) {
    on<PostAuth>((event, emit) async {
      emit(AuthLoading());
      try {
        AuthEntity entity =
            await userRepository.authWithNickname(authPostEntity: event.entity);
        emit(AuthSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(AuthFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(AuthFailure(message: 'unable to login: $e'));
      }
    });

    on<GetIsLoggedIn>((event, emit) async {
      emit(AuthLoading());
      try {
        emit(AuthIsLoggedIn(isLoggedIn: userRepository.isHasLoggedIn));
      } on FailedException catch (e) {
        FailedException fail = e.error;
        emit(AuthFailure(message: fail.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(AuthFailure(message: 'unable to login: $e'));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(AuthLoading());
      try {
        await userRepository.changePassword(
            postChangePasswordEntity: event.entity);
        emit(ChangeSuccess());
      } on FailedException catch (e) {
        FailedException fail = e.error;
        emit(AuthFailure(message: fail.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(AuthFailure(message: 'unable to change: $e'));
      }
    });

    on<ChangePin>((event, emit) async {
      emit(AuthLoading());
      try {
        await userRepository.changePin(postChangePinEntity: event.entity);
        emit(ChangeSuccess());
      } on FailedException catch (e) {
        FailedException fail = e.error;
        emit(AuthFailure(message: fail.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(AuthFailure(message: 'unable to change: $e'));
      }
    });
  }
}
