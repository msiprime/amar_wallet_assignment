import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'barcode_state.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit() : super(BarcodeInitial());

  void onBarcodeScanned({
    required Barcode? barcode,
  }) {
    try {
      if (barcode == null) {
        emit(BarcodeError("No Barcode Found!"));
        return;
      }

      if (barcode.displayValue == null) {
        emit(BarcodeError("No Barcode Value Found!"));
        return;
      }
      emit(BarcodeScanned(barcode.displayValue!));
    } catch (e) {
      emit(BarcodeError("Error Scanning The Barcode!"));
    }
  }

  void onBarcodeError({
    required Object error,
    required StackTrace stacktrace,
  }) {
    log("Error Scanning The Barcode: $error", stackTrace: stacktrace);
    emit(BarcodeError("Error Scanning The Barcode!"));
  }
}
