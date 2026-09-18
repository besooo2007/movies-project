import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class CastItemData {
  final AssetGenImage image;
  final String name;
  final String character;

  const CastItemData({
    required this.image,
    required this.name,
    required this.character,
  });
}

class CastWidget extends StatelessWidget {
  final List<CastItemData>? castList;

  const CastWidget({

    super.key,
    this.castList,

  });

  @override
  Widget build(BuildContext context) {
    final list = castList ??
        [
          CastItemData(

            image: Assets.images.imgCast1,
            name: "Hayley Atwell",
            character: "Captain Carter",

          ),
          CastItemData(
            image: Assets.images.imgCast2,
            name: "Elizabeth Olsen",
            character: "Wanda Maximoff / The Scarlet Witch",
          ),
          CastItemData(
            image: Assets.images.imgCast3,
            name: "Rachel McAdams",
            character: "Dr. Christine Palmer",
          ),
          CastItemData(
            image: Assets.images.imgCast4,
            name: "Charlize Theron",
            character: "Clea",
          ),
        ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cast",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: list.map((cast) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: cast.image.image(
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name : ${cast.name}",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Character : ${cast.character}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
