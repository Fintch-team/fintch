import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsInit extends SettingsEvent {}

class BiometricInit extends SettingsEvent {}

class BiometricAuth extends SettingsEvent {}

class ChangeImgProfile extends SettingsEvent {
  final File entity;

  ChangeImgProfile({required this.entity});

  @override
  List<Object> get props => [entity];
}
