import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/core.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double size;
  final Color color;

  const StarRating({
    super.key,
    this.rating = 5,
    this.size = 32.0,
    this.color = AppColors.primaryOrange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        rating,
        (index) => TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 200 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Icon(Iconsax.star1, size: size, color: color),
            );
          },
        ),
      ),
    );
  }
}
