import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WalletCardWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.red.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(imageUrl, scale: 0.25),
                radius: context.height * 0.048,
              ),
              const SizedBox.shrink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(storeName, style: context.textTheme.headlineSmall),
                  Text(
                    cardType,
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
