part of 'barcode_cubit.dart';

sealed class BarcodeState extends Equatable {
  const BarcodeState();
}

final class BarcodeInitial extends BarcodeState {
  @override
  List<Object> get props => [];
}

final class BarcodeLoading extends BarcodeState {
  @override
  List<Object> get props => [];
}

final class BarcodeScanned extends BarcodeState {
  final String barcodeNumber;

  BarcodeScanned(
    this.barcodeNumber,
  );

  @override
  List<Object> get props => [barcodeNumber];
}

final class WalletFound extends BarcodeState {
  final WalletCardDetailsEntity wallet;

  WalletFound(this.wallet);

  @override
  List<Object> get props => [wallet];
}

final class BarcodeError extends BarcodeState {
  final String message;

  BarcodeError(this.message);

  @override
  List<Object> get props => [message];
}

final class WalletAdded extends BarcodeState {
  final List<WalletCardDetailsEntity> wallets;

  WalletAdded(this.wallets);

  @override
  List<Object> get props => [wallets];
}
