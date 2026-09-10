import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextForm({
    super.key,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          color: AppColors.textcolor,
        ),

        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: prefixIcon,
        ),

        suffixIcon: suffixIcon,

        filled: true,

        fillColor: AppColors.formcolor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.formcolor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.formcolor,
          ),
        ),
      ),

      cursorColor: AppColors.textcolor,
    );
  }
}