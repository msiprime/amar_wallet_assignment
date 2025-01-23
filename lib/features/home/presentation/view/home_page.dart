import 'package:amar_wallet_assignment/global/widgets/app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        child: Column(
          children: [
            const Gap(8),
            CardCarousel(images: imageURLs),
            SizedBox(height: 300),
          ],
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

class CardCarousel extends StatelessWidget {
  final List<String> images;

  const CardCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height * 0.3),
      child: CarouselView.weighted(
        flexWeights: [1],
        itemSnapping: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shrinkExtent: 350,
        children: images.map((String url) {
          return ClipRect(
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fitWidth,
            ),
          );
        }).toList(),
      ),
    );
  }
}

const List<String> imageURLs = [
  'https://i.ibb.co.com/mbcvj7G/bank4.png',
  'https://i.ibb.co.com/L5vM9mt/bank2.png',
  'https://i.ibb.co.com/RBNXbqk/bank3.png',
  'https://i.ibb.co.com/4SzG3fZ/bank1.png',
];
