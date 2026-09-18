import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final String summary;

  const SummaryWidget({
    super.key,
    this.summary =
        "Following the events of Spider-Man No Way Home, Doctor Strange"
            " unwittingly casts a forbidden spell that accidentally"
            " opens up the multiverse. With help from Wong and Scarlet Witch,"
            " Strange confronts various versions of himself as well as "
            "teaming up with the young America Chavez while traveling through"
            " various realities and working to restore reality as he knows it."
            " Along the way, Strange and his allies realize "
            "they must take on a powerful new adversary who seeks to take over"
            " the multiverse.—Blazer346",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Summary",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          summary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
