import 'package:flutter/material.dart';
import '../../../../../../core/theme/AppColors.dart';
import '../../../../../../core/gen/assets.gen.dart';

class AvatarBottomSheet extends StatefulWidget {
  final int selectedIndex;
  const AvatarBottomSheet({super.key, required this.selectedIndex});

  @override
  State<AvatarBottomSheet> createState() => _AvatarBottomSheetState();
}

class _AvatarBottomSheetState extends State<AvatarBottomSheet> {
  late int currentSelectedIndex;

  final List<AssetGenImage> avatars = [
    Assets.images.avatar1,
    Assets.images.avatar2,
    Assets.images.avatar3,
    Assets.images.avatar4,
    Assets.images.avatar5,
    Assets.images.avatar6,
    Assets.images.avatar7,
    Assets.images.avatar8,
    Assets.images.avatar9,
  ];

  @override
  void initState() {
    super.initState();
    currentSelectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final isSelected = currentSelectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentSelectedIndex = index;
                  });
                  Navigator.pop(context, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected ? AppColors.yellow : Colors.transparent,
                      width: 2,
                    ),
                    color: isSelected
                        ? AppColors.yellow.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: avatars[index].image(fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
