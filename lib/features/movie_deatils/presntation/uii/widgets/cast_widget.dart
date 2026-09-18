import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';
import 'package:flutter/material.dart';

class CastWidget extends StatelessWidget {
  final List<CastEntity>? cast;

  const CastWidget({
    super.key,
    this.cast,
  });

  @override
  Widget build(BuildContext context) {
    final castList = cast ?? [];

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

     
        if (castList.isEmpty)
          Column(
            children: [
              _buildStaticCast(
                context,
                Assets.images.imgCast1,
                "Hayley Atwell",
                "Captain Carter",
              ),
              _buildStaticCast(
                context,
                Assets.images.imgCast2,
                "Elizabeth Olsen",
                "Wanda Maximoff / The Scarlet Witch",
              ),
              _buildStaticCast(
                context,
                Assets.images.imgCast3,
                "Rachel McAdams",
                "Dr. Christine Palmer",
              ),
              _buildStaticCast(
                context,
                Assets.images.imgCast4,
                "Charlize Theron",
                "Clea",
              ),
            ],
          ),

      
        if (castList.isNotEmpty)
          Column(
            children: castList.map((actor) {
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
                        child: Image.network(
                          actor.image,
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 65,
                              height: 65,
                              color: AppColors.grey,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white54,
                                size: 35,
                              ),
                            );
                          },
                          loadingBuilder: (
                            context,
                            child,
                            loadingProgress,
                          ) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return Container(
                              width: 65,
                              height: 65,
                              color: AppColors.grey,
                              alignment: Alignment.center,
                              child: const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ${actor.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Character : ${actor.character}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
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

  Widget _buildStaticCast(
    BuildContext context,
    AssetGenImage image,
    String name,
    String character,
  ) {
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
              child: image.image(
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
                    "Name : $name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Character : $character",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
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
  }
}