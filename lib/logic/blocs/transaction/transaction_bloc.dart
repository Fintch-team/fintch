import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fintch/gen_export.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
