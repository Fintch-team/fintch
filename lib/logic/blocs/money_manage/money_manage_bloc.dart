import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

class MoneyManageBloc extends Bloc<MoneyManageEvent, MoneyManageState> {
  MoneyManageBloc() : super(MoneyManageInitial()) {
    on<MoneyManageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
