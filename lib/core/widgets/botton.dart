import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? image;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.bottoncolora,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: Size(double.infinity, 55),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ?image,
          SizedBox(width: 8),
          Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.formcolor,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
