part of 'barcode_cubit.dart';

sealed class BarcodeState extends Equatable {
  const BarcodeState();
}

final class BarcodeInitial extends BarcodeState {
  @override
  List<Object> get props => [];
}

final class BarcodeScanned extends BarcodeState {
  final String barcode;

  BarcodeScanned(
    this.barcode,
  );

  @override
  List<Object> get props => [barcode];
}

final class BarcodeError extends BarcodeState {
  final String message;

  BarcodeError(this.message);

  @override
  List<Object> get props => [message];
}

//  Barcode? _barcode;
//
//   Widget _buildBarcode(Barcode? value) {
//     if (value == null) {
//       return const Text(
//         'Scan something!',
//         overflow: TextOverflow.fade,
//         style: TextStyle(color: Colors.white),
//       );
//     }
//
//     return Text(
//       value.displayValue ?? 'No display value.',
//       overflow: TextOverflow.fade,
//       style: const TextStyle(color: Colors.white),
//     );
//   }
//
//   void _handleBarcode(BarcodeCapture barcodes) {
//     if (mounted) {
//       setState(() {
//         log('Barcode: ${barcodes.barcodes.firstOrNull}');
//         _barcode = barcodes.barcodes.firstOrNull;
//       });
//     }
//   }
