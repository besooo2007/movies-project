import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPosterIndex = 0;

  final List<String> _carouselImages = [
    Assets.images.poster1.path,
    Assets.images.poster2.path,
    Assets.images.poster3.path,
    Assets.images.poster4.path,
    Assets.images.poster5.path,
  ];

  final List<String> _actionMovies = [
    Assets.images.poster3.path,
    Assets.images.poster4.path,
    Assets.images.poster5.path,
    Assets.images.poster2.path,
    Assets.images.poster1.path,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Stack(
                      key: ValueKey<int>(_currentPosterIndex),
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          _carouselImages[_currentPosterIndex],
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.45),
                                Colors.black.withValues(alpha: 0.65),
                                const Color(0xCC121312),
                                const Color(0xFF121312),
                              ],
                              stops: const [0.0, 0.4, 0.75, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      Center(
                        child: Assets.images.availableNow.image(
                          height: 93,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),

                      CarouselSlider.builder(
                        itemCount: _carouselImages.length,
                        itemBuilder: (context, index, realIndex) {
                          return _buildCarouselCard(_carouselImages[index]);
                        },
                        options: CarouselOptions(
                          height: 351,
                          initialPage: 0,
                          viewportFraction: 0.58,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.22,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPosterIndex = index;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // "Watch Now" asset image
                      Center(
                        child: Assets.images.watchNow.image(
                          height: 146,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Action section title & See More
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Action',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See More',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.bottoncolora,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFF6BD00),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Action movies horizontal list
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _actionMovies.length,
                itemBuilder: (context, index) {
                  return _buildMovieCard(_actionMovies[index]);
                },
              ),
            ),

            // Bottom space for floating bottom navigation bar
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '7.7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Assets.icons.star.image(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '7.7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 3),
                  Assets.icons.star.image(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
