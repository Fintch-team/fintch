import 'package:bloc/bloc.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

mixin BarcodeSheetBloc on Bloc<BarcodeEvent, BarcodeState> {}

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState>
    implements BarcodeSheetBloc {
  final BarcodeRepository barcodeRepository;
  final UserRepository userRepository;

  BarcodeBloc({required this.barcodeRepository, required this.userRepository})
      : super(BarcodeInitial()) {
    on<GetBarcode>((event, emit) async {
      emit(BarcodeLoading());
      try {
        ListBarcodeEntity barcode = await barcodeRepository.getAllBarcode();
        emit(BarcodeResponseSuccess(entity: barcode));
      } on FailedException catch (e) {
        emit(BarcodeFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(BarcodeFailure(message: 'unable to get barcode: $e'));
      }
    });

    on<PostBarcode>((event, emit) async {
      emit(BarcodeLoading());
      try {
        await barcodeRepository.postBarcode(postEntity: event.entity);
        emit(BarcodeRequestSuccess());
      } on FailedException catch (e) {
        emit(BarcodeFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(BarcodeFailure(message: 'unable to get barcode: $e'));
      }
    });

    on<EditBarcode>((event, emit) async {
      emit(BarcodeLoading());
      try {
        await barcodeRepository.editBarcode(putEntity: event.entity);
        emit(BarcodeRequestSuccess());
      } on FailedException catch (e) {
        emit(BarcodeFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(BarcodeFailure(message: 'unable to get barcode: $e'));
      }
    });

    on<DeleteBarcode>((event, emit) async {
      emit(BarcodeLoading());
      try {
        await barcodeRepository.deleteBarcode(idBarcode: event.id.toString());
        emit(DeleteBarcodeRequestSuccess());
      } on FailedException catch (e) {
        emit(BarcodeFailure(message: e.message));
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(BarcodeFailure(message: 'unable to get barcode: $e'));
      }
    });
  }
}
