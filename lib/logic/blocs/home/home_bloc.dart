import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<HomeInit>((event, emit) async {
      emit(HomeLoading());
      try {
        UserEntity entity = await userRepository.currentUser();
        emit(HomeSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(HomeFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HomeFailure(message: 'unable to get user: $e'));
      }
    });
  }
}
