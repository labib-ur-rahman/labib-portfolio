import 'package:flutter/material.dart';
import '../../../core/core.dart';
import 'star_rating.dart';

class ExperienceCard extends StatelessWidget {
  final String years;
  final String label;

  const ExperienceCard({super.key, required this.years, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Star Rating
        StarRating(rating: 5, size: isMobile ? 20 : (isDesktop ? 32 : 26)),
        SizedBox(height: isDesktop ? 21 : 12),
        // Years
        Text(
          years,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: isMobile ? 28 : (isDesktop ? 47 : 36),
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.705,
          ),
        ),
        const SizedBox(height: 5),
        // Label
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: isMobile ? 14 : (isDesktop ? 20 : 16),
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
