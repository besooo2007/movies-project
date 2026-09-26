import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';

import 'package:app/features/browser/browse%20tab/presentation/ui/browse_view.dart';
import 'package:app/features/home_api/presnation/bloc/ui/home_screen.dart';
import 'package:app/features/profile_api/presentation/ui/profile_view.dart';
import 'package:app/features/search/presentation/search_view.dart';

import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const SearchView(),

      const HomeScreen(),

      const BrowseView(),

      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(child: pages[_selectedIndex]),

          Positioned(
            left: 8,
            right: 8,
            bottom: 9,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
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
