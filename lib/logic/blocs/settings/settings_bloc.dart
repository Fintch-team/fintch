import 'package:bloc/bloc.dart';

import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin BiometricBloc on Bloc<SettingsEvent, SettingsState> {}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with BiometricBloc {
  final UserRepository userRepository;

  SettingsBloc({required this.userRepository}) : super(SettingsInitial()) {
    on<SettingsInit>((event, emit) async {
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

    on<BiometricInit>((event, emit) async {
      emit(SettingsLoading());
      try {
        bool entity = await userRepository.hasBiometrics();
        emit(SettingsBoolSuccess(entity: entity));
      } on FailedException catch (e) {
        emit(SettingsFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(SettingsFailure(message: 'unable to get user: $e'));
      }
    });

    on<BiometricAuth>((event, emit) async {
      emit(SettingsLoading());
      try {
        bool isAuth = await userRepository.authBiometrics();
        if (isAuth) {
          BioUserEntity entity = await userRepository.bioUser();

          emit(SettingsBioSuccess(entity: entity));
        } else {
          emit(SettingsFailure(message: 'Biometric login failed'));
        }
      } on FailedException catch (e) {
        emit(SettingsFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(SettingsFailure(message: 'unable to get user: $e'));
      }
    });

    on<ChangeImgProfile>((event, emit) async {
      emit(SettingsLoading());
      try {
        bool entity = await userRepository.changeImgProfile(img: event.entity);
        if (entity) {
          UserEntity entity = await userRepository.currentUser();
          emit(SettingsSuccess(entity: entity));
        } else {
          emit(SettingsBoolSuccess(entity: entity));
        }
      } on FailedException catch (e) {
        emit(SettingsFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(SettingsFailure(message: 'unable to get user: $e'));
      }
    });
  }
}
