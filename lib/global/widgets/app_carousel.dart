import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppCarouselSlider extends StatelessWidget {
  final List<String> imageUrls;
  final double aspectRatio;
  final double indicatorSize;
  final double selectedIndicatorSize;
  final bool autoPlay;
  final bool enlargeCenterPage;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;
  final double height;
  final double radius = 12.0;

  AppCarouselSlider({
    super.key,
    required this.imageUrls,
    this.aspectRatio = 1.0,
    this.indicatorSize = 6.0,
    this.selectedIndicatorSize = 8.0,
    this.autoPlay = true,
    this.enlargeCenterPage = true,
    this.activeIndicatorColor = Colors.black,
    this.inactiveIndicatorColor = Colors.grey,
    required this.height,
  });

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: RepaintBoundary(
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              autoPlayCurve: Curves.ease,
              autoPlay: autoPlay,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              height: height - 30,
              onPageChanged: (index, reason) {
                _currentIndexNotifier.value = index;
              },
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder(
            valueListenable: _currentIndexNotifier,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imageUrls.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: CustomPaint(
                      size: const Size(10, 10),
                      painter: CircleIndicatorPainter(
                          isActive: index == value, context: context),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CircleIndicatorPainter extends CustomPainter {
  final bool isActive;
  final BuildContext context;

  CircleIndicatorPainter({required this.isActive, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius - 2;

    final ThemeData themeData = Theme.of(context);

    final Paint borderPaint = Paint()
      ..color = themeData.colorScheme.onSurface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.24;

    final Paint fillPaint = Paint()
      ..color = isActive
          ? themeData.colorScheme.onSurface
          : themeData.colorScheme.surface
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(size.center(Offset.zero), outerRadius, borderPaint);
    canvas.drawCircle(size.center(Offset.zero), innerRadius, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
