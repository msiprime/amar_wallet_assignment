import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/cubit/barcode_cubit.dart';
import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeCubit(),
      child: BarcodeScannerView(),
    );
  }
}

class BarcodeScannerView extends StatelessWidget {
  const BarcodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1E1E),
      body: SafeArea(
        child: BlocListener<BarcodeCubit, BarcodeState>(
          listener: (context, state) {
            if (state is BarcodeScanned) {
              context.showSnackBar(
                "Barcode Scanned: ${state.barcode}",
              );
            } else if (state is BarcodeError) {
              context.showSnackBar(
                "Error Scanning Barcode: ${state.message}",
                color: Colors.red,
              );
              // Handle the error
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              Center(child: HeaderPart()),
              BarcodeScannerWidget(),
              Text(
                "Scan the Bar or QR code",
                style:
                    context.textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButtons(),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xFF1F1E1E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: context.theme.colorScheme.onPrimary,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Enter Manually"),
          ),
        ],
      ),
    );
  }
}

class BarcodeScannerWidget extends StatelessWidget {
  const BarcodeScannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: context.height * 0.35,
      width: context.width * 1,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: MobileScanner(
        overlayBuilder: (context, constraints) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white,
                style: BorderStyle.solid,
                width: 2,
              ),
            ),
          );
        },
        onDetect: (barcodes) {
          context
              .read<BarcodeCubit>()
              .onBarcodeScanned(barcode: barcodes.barcodes.firstOrNull);
        },
        onDetectError: (error, stackTrace) {
          context
              .read<BarcodeCubit>()
              .onBarcodeError(error: error, stacktrace: stackTrace);
        },
        scanWindow: const Rect.fromLTRB(0.2, 0.2, 0.6, 0.6),
        // onDetect: _handleBarcode,
      ),
    );
  }
}

class HeaderPart extends StatelessWidget {
  const HeaderPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.document_scanner_rounded,
          size: context.height * 0.05,
          color: context.colorScheme.onPrimary,
        ),
        const SizedBox(height: 16),
        Text(
          "Add a Card",
          style: context.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
