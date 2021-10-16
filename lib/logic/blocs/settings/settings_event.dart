import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsInit extends SettingsEvent {}

class BiometricInit extends SettingsEvent {}

class BiometricAuth extends SettingsEvent {}
