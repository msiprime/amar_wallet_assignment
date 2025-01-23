import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          AppBarSliver(),
          SliverGap(16),
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: [
                Container(
                  height: 100,
                  color: Colors.red,
                  child: Center(
                    child: Text('Page 1'),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.green,
                  child: Center(
                    child: Text('Page 2'),
                  ),
                ),
                // ... Add more carousel items here
              ],
              options: CarouselOptions(
                height: 100.0, // Adjust height as needed
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  // Handle page change if needed
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item #$index'),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarSliver extends StatelessWidget {
  const AppBarSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      title: CircleAvatar(
        radius: 24,
        backgroundImage: CachedNetworkImageProvider(
          'https://avatars.githubusercontent.com/u/107892662?v=4',
        ),
      ),
      floating: false,
      pinned: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }
}
