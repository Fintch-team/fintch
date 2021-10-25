import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final UserEntity entity;

  SettingsSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class SettingsBoolSuccess extends SettingsState {
  final bool entity;

  SettingsBoolSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class SettingsBioSuccess extends SettingsState {
  final BioUserEntity entity;

  SettingsBioSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class SettingsFailure extends SettingsState {
  final String message;

  SettingsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
