import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? image;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.bottoncolora,
        minimumSize: const Size(0, 55),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null) ...[
            image!,
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: color == AppColors.red
                  ? Colors.white
                  : AppColors.formcolor,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}