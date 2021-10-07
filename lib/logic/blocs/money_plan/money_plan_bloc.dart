import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintch/gen_export.dart';

class MoneyPlanBloc extends Bloc<MoneyPlanEvent, MoneyPlanState> {
  MoneyPlanBloc() : super(MoneyPlanInitial()) {
    on<MoneyPlanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
