import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/barcode_scanner_view.dart';
import 'package:amar_wallet_assignment/features/home/presentation/widget/wallet_card_widget.dart';
import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:amar_wallet_assignment/global/widgets/app_bar.dart';
import 'package:amar_wallet_assignment/global/widgets/app_carousel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HomeFloatingActionButton(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Gap(8),
              AppCarouselSlider(
                imageUrls: imageURLs,
                height: context.height * 0.33,
              ),
              const Gap(16),
              WalletCardWidget(
                imageUrl: 'https://i.ibb.co.com/HCwcrXd/kfc.png',
                storeName: 'K F C',
                cardType: 'Gift Card',
              ),
              const Gap(16),
              WalletCardWidget(
                imageUrl: 'https://i.ibb.co.com/6PgJJcX/starbucks.png',
                storeName: 'Starbucks',
                cardType: 'Loyalty Card',
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Add to wallet'),
      isExtended: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeScannerScreen(),
          ),
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}

const List<String> imageURLs = [
  'https://i.ibb.co.com/mbcvj7G/bank4.png',
  'https://i.ibb.co.com/L5vM9mt/bank2.png',
  'https://i.ibb.co.com/RBNXbqk/bank3.png',
  'https://i.ibb.co.com/4SzG3fZ/bank1.png',
];
