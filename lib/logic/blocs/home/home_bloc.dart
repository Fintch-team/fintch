import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<GetUser>((event, emit) {
      emit(HomeLoading());
      try {
        UserEntity entity = userRepository.currentUser();
        emit(HomeSuccess(entity: entity));
      } on FailedException catch (e) {
        FailedException fail = e.error;
        emit(HomeFailure(message: fail.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HomeFailure(message: 'unable to get user: $e'));
      }
    });
  }
}
