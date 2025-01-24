import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/cubit/barcode_cubit.dart';
import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'barcode_scanner_view_2.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeCubit(),
      // child: BarcodeScannerWithOverlay(),
      child: BarcodeScannerView(),
    );
  }
}

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

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
              // BarcodeScannerWidget(),
              SizedBox(
                height: context.height * 0.35,
                width: context.width * 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: MobileScanner(
                        fit: BoxFit.contain,
                        controller: controller,
                        // scanWindow: scanWindow,
                        onDetect: (barcodes) async {
                          controller.stop();
                          context.read<BarcodeCubit>().onBarcodeScanned(
                              barcode: barcodes.barcodes.firstOrNull);
                          // Navigator.pop(context);
                        },
                        errorBuilder: (context, error, child) {
                          return ScannerErrorWidget(error: error);
                        },
                        overlayBuilder: (context, constraints) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ScannedBarcodeLabel(
                                  barcodes: controller.barcodes),
                              //here is the value
                            ),
                          );
                        },
                      ),
                    ),
                    // ValueListenableBuilder(
                    //   valueListenable: controller,
                    //   builder: (context, value, child) {
                    //     if (!value.isInitialized ||
                    //         !value.isRunning ||
                    //         value.error != null) {
                    //       return const SizedBox();
                    //     }
                    //     return CustomPaint(
                    //       painter: ScannerOverlay(scanWindow: scanWindow),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
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

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({
    super.key,
  });

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  late final MobileScannerController controller;

  @override
  void initState() {
    controller = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
    );
    super.initState();
  }

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
        child: MobileScanner(
          controller: controller,

          overlayBuilder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ScannedBarcodeLabel(barcodes: controller.barcodes),
                //here is the value
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

//import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:mobile_scanner_example/scanned_barcode_label.dart';
// import 'package:mobile_scanner_example/scanner_button_widgets.dart';
// import 'package:mobile_scanner_example/scanner_error_widget.dart';
//
// class BarcodeScannerWithController extends StatefulWidget {
//   const BarcodeScannerWithController({super.key});
//
//   @override
//   State<BarcodeScannerWithController> createState() =>
//       _BarcodeScannerWithControllerState();
// }
//
// class _BarcodeScannerWithControllerState
//     extends State<BarcodeScannerWithController> with WidgetsBindingObserver {
//   final MobileScannerController controller = MobileScannerController(
//     autoStart: false,
//     // torchEnabled: true,
//     autoZoom: true,
//     // invertImage: true,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     unawaited(controller.start());
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!controller.value.hasCameraPermission) {
//       return;
//     }
//
//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//         unawaited(controller.start());
//       case AppLifecycleState.inactive:
//         unawaited(controller.stop());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('With controller')),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             errorBuilder: (context, error) {
//               return ScannerErrorWidget(error: error);
//             },
//             fit: BoxFit.contain,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               height: 100,
//               color: const Color.fromRGBO(0, 0, 0, 0.4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ToggleFlashlightButton(controller: controller),
//                   StartStopMobileScannerButton(controller: controller),
//                   PauseMobileScannerButton(controller: controller),
//                   Expanded(
//                     child: Center(
//                       child: ScannedBarcodeLabel(
//                         barcodes: controller.barcodes,
//                       ),
//                     ),
//                   ),
//                   SwitchCameraButton(controller: controller),
//                   AnalyzeImageFromGalleryButton(controller: controller),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Future<void> dispose() async {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//     await controller.dispose();
//   }
// }
