import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/feature/browse%20tab/presentation/ui/browse_view.dart';
import 'package:app/feature/home/presentation/ui/Home_Screen.dart';
import 'package:app/feature/profile/presentation/ui/profile_view.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
    const HomeScreen(),

    const BrowseView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          IndexedStack(index: _selectedIndex, children: _pages),
          Positioned(
            left: 8,
            right: 8,
            bottom: 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Assets.images.vector3.image(), 1),
                    _buildNavItem(Assets.images.vector2.image(), 0),
                    _buildNavItem(Assets.icons.explore.image(), 2),
                    _buildNavItem(Assets.icons.profiel.image(), 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(Widget image, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isSelected ? const Color(0xFFF6BD00) : Colors.white,
          BlendMode.srcIn,
        ),
        child: SizedBox(width: 26, height: 26, child: image),
      ),
    );
  }
}
