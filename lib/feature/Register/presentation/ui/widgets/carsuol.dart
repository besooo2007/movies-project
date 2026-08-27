import 'package:app/core/gen/assets.gen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CaruselAvatars extends StatelessWidget {
  const CaruselAvatars({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AssetGenImage> avatars = [
      Assets.images.avatar2,
      Assets.images.avatar1,
      Assets.images.avatar3,
    ];
    return CarouselSlider.builder(
      itemCount: avatars.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            backgroundImage: avatars[index].provider(),
          ),
        );
      },
      options: CarouselOptions(
        height: 140,
        initialPage: 1,
        viewportFraction: 0.35,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        enableInfiniteScroll: false,
      ),
    );
  }
}
