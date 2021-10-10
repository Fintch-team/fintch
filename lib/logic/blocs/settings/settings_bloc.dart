import 'package:bloc/bloc.dart';

import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository userRepository;

  SettingsBloc({required this.userRepository}) : super(SettingsInitial()) {
    on<SettingsInit>((event, emit) async {
      // TODO: di bawah ini bisa lebih baik di mixin ke home
      emit(SettingsLoading());
      try {
        UserEntity entity = await userRepository.currentUser();
        emit(SettingsSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(SettingsFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(SettingsFailure(message: 'unable to get user: $e'));
      }
    });
  }
}
