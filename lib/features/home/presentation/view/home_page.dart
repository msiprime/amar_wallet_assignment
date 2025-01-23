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
                height: MediaQuery.sizeOf(context).height * 0.33,
              ),
              const Gap(16),
              const Text(
                'Welcome to Amar Wallet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade900,
                    width: 3,
                  ),
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    color: Colors.grey.shade900,
                    shape: BoxShape.circle,
                  ),
                ),
              )
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            hitTestBehavior: HitTestBehavior.opaque,
            behavior: SnackBarBehavior.floating,
            closeIconColor: Colors.blue,
            dismissDirection: DismissDirection.startToEnd,
            content: Text('Added to wallet'),
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
