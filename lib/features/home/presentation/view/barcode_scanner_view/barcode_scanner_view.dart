import 'package:amar_wallet_assignment/features/home/data/repository/home_repo_impl.dart';
import 'package:amar_wallet_assignment/features/home/data/source/home_datasource_impl.dart';
import 'package:amar_wallet_assignment/features/home/data/source/local/local_home_datasource_impl.dart';
import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/cubit/barcode_cubit.dart';
import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/wallet_found_screen.dart';
import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeCubit(
        homeRepository: HomeRepoImpl(
          homeDataSource: HomeDataSourceImpl(),
          localHomeDataSource: LocalHomeDataSourceImpl(),
        ),
      ),
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
    formats: [
      BarcodeFormat.codebar,
      BarcodeFormat.qrCode,
      BarcodeFormat.code128
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1E1E),
      body: SafeArea(
        child: BlocListener<BarcodeCubit, BarcodeState>(
          listener: (context, state) {
            if (state is BarcodeScanned) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      WalletFoundScreen(barcodeNumber: state.barcodeNumber),
                ),
              );
            } else if (state is BarcodeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              Center(child: HeaderPart()),
              SizedBox(
                height: context.height * 0.35,
                width: context.width * 0.8,
                child: Center(
                  child: MobileScanner(
                    fit: BoxFit.contain,
                    controller: controller,
                    onDetect: (barcodes) async {
                      controller.stop();
                      context.read<BarcodeCubit>().onBarcodeScanned(
                          barcode: barcodes.barcodes.firstOrNull);
                    },
                    overlayBuilder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ScannedBarcodeLabel(
                                barcodes: controller.barcodes),
                            //here is the value
                          ),
                        ),
                      );
                    },
                  ),
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

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return const Text(
            'Scan something!',
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        return Text(
          scannedBarcodes.first.displayValue ?? 'No display value.',
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
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
