import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fintch/gen_export.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
