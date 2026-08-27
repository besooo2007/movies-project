import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class LanguageToggleSwitch extends StatefulWidget {
  final Function(bool isArabic)? onChanged;

  const LanguageToggleSwitch({super.key, this.onChanged});

  @override
  State<LanguageToggleSwitch> createState() => _LanguageToggleSwitchState();
}

class _LanguageToggleSwitchState extends State<LanguageToggleSwitch> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isArabic = !isArabic;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(isArabic);
        }
      },
      child: Container(
        width: 100,
        height: 50,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.bottoncolora, width: 3),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.bottoncolora, width: 4),
            ),
            child: ClipOval(
              child: (isArabic ? Assets.icons.eg : Assets.icons.us).image(
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
