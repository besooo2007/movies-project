import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class GenreTabItem extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreTabItem({
    super.key,
    required this.genre,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.bottoncolora : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.bottoncolora,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            genre,
            style: TextStyle(
              color: isSelected ? const Color(0xFF121312) : AppColors.bottoncolora,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
