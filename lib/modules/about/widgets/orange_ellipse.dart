import 'package:flutter/material.dart';
import '../../../core/core.dart';

class OrangeEllipse extends StatelessWidget {
  final double width;
  final double height;

  const OrangeEllipse({
    super.key,
    this.width = AppDimensions.orangeCircleWidth,
    this.height = AppDimensions.orangeCircleHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.primaryOrangeLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(500),
          topRight: Radius.circular(500),
        ),
      ),
    );
  }
}
