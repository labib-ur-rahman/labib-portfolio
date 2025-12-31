import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/core.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double blurAmount;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BoxConstraints? constraints;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = AppDimensions.radiusL,
    this.margin,
    this.padding,
    this.blurAmount = 7.5,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2.0,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          width: width, 
          height: height,
          constraints: constraints,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.backgroundGlass,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? AppColors.borderLight,
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
