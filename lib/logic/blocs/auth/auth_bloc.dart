import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is PostAuth) {
      yield* _mapPostAuthToState(event);
    }
  }

  Stream<AuthState> _mapPostAuthToState(PostAuth event) async* {
    yield AuthLoading();
    try {
      AuthEntity entity =
          await userRepository.authWithNickname(authPostEntity: event.entity);

      yield AuthSuccess(entity: entity);
    } catch (e, stacktrace) {
      yield AuthFailure(message: 'unable to login: $e ${stacktrace.toString()}');
    }
  }
}
