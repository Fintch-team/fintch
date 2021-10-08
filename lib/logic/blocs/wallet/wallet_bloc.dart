import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
