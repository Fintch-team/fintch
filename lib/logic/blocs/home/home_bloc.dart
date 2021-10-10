import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin ReceiveBloc on Bloc<HomeEvent, HomeState> {}

class HomeBloc extends Bloc<HomeEvent, HomeState> with ReceiveBloc {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<HomeInit>((event, emit) async {
      emit(HomeLoading());
      try {
        UserEntity entity = await userRepository.currentUser();
        emit(HomeSuccess(entity: entity));
      } on FailedException catch (e, stacktrace) {
        debugPrint(e.message);
        debugPrint(stacktrace.toString());
        emit(HomeFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(HomeFailure(message: 'unable to get user: $e'));
      }
    });
  }
}
