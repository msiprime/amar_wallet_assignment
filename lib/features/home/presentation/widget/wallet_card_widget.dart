import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class WalletCardWidget extends StatefulWidget {
  final String imageUrl;
  final String storeName;
  final String cardType;

  const WalletCardWidget({
    super.key,
    required this.imageUrl,
    required this.storeName,
    required this.cardType,
  });

  @override
  State<WalletCardWidget> createState() => _WalletCardWidgetState();
}

class _WalletCardWidgetState extends State<WalletCardWidget> {
  Color? dominantColor;

  @override
  void initState() {
    _getDominantColor();
    super.initState();
  }

  Future<void> _getDominantColor() async {
    try {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(widget.imageUrl),
        maximumColorCount: 1,
      );
      setState(() {
        dominantColor = paletteGenerator.dominantColor?.color.withOpacity(0.25);
      });
    } catch (e) {
      setState(() {
        dominantColor = Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: dominantColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(widget.imageUrl),
                radius: context.height * 0.048,
              ),
              const SizedBox.shrink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(widget.storeName,
                      style: context.textTheme.headlineSmall),
                  Text(
                    widget.cardType,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            right: 0,
            child: Badge(
              label: Text('1'),
              largeSize: context.height * 0.03,
            )),
      ],
    );
  }
}
