import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class StatsRowWidget extends StatelessWidget {
  final String likes;
  final String duration;
  final String rating;

  const StatsRowWidget({
    super.key,
    this.likes = "15",
    this.duration = "90",
    this.rating = "7.6",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatPill(
            icon: Assets.icons.icHeart.svg(width: 20, height: 20),
            value: likes,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatPill(
            icon: Assets.icons.icClock.svg(width: 20, height: 20),
            value: duration,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatPill(
            icon: Assets.icons.icStar.svg(width: 20, height: 20),
            value: rating,
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  final Widget icon;
  final String value;

  const _StatPill({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
