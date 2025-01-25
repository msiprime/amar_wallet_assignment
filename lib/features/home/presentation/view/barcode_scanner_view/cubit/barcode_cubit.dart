import 'dart:developer';

import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:amar_wallet_assignment/features/home/domain/repository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'barcode_state.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  final HomeRepository _homeRepository;

  BarcodeCubit({
    required HomeRepository homeRepository,
  })  : _homeRepository = homeRepository,
        super(BarcodeInitial());

  void onBarcodeScanned({
    required Barcode? barcode,
  }) async {
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

  Future<void> findWalletData({
    required String barcodeNumber,
  }) async {
    try {
      emit(BarcodeLoading());

      final response = await _homeRepository.findWalletData(
        barcodeNumber: barcodeNumber,
      );

      response.fold(
        (failure) => emit(BarcodeError("Error fetching data")),
        (wallet) => emit(WalletFound(wallet)),
      );
    } catch (e) {
      emit(BarcodeError("Error fetching data"));
    }
  }

  Future<void> addWalletData({
    required WalletCardDetailsEntity wallet,
  }) async {
    try {
      emit(BarcodeLoading());

      final response = await _homeRepository.addMyWallet(
        wallet: wallet,
      );

      response.fold(
        (failure) => emit(BarcodeError("Error adding wallet")),
        (wallets) => emit(WalletAdded(wallets)),
      );
    } catch (e) {
      emit(BarcodeError("Error adding wallet"));
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
