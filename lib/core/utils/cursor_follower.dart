import 'package:DeveloperLabib/core/core.dart';
import 'package:flutter/material.dart';

class CursorFollower extends StatelessWidget {
  const CursorFollower({
    required this.position,
    required this.size,
    required this.isVisible,
  });

  final Offset position;
  final double size;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final bigLeft = position.dx - size / 2;
    final bigTop = position.dy - size / 2;

    final smallSize = size * 0.3;
    final smallLeft = position.dx - smallSize / 2;
    final smallTop = position.dy - smallSize / 2;

    return Positioned.fill(
      child: Stack(
        children: [
          // Big ring — slower, painted below
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            left: bigLeft,
            top: bigTop,
            child: IgnorePointer(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 50),
                opacity: isVisible ? 1 : 0,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryOrange.withValues(alpha: 0.12),
                    border: Border.all(
                      color: AppColors.primaryOrange.withValues(alpha: 0.55),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryOrange.withValues(alpha: 0.25),
                        blurRadius: 22,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Small dot — faster, painted above the big ring
          AnimatedPositioned(
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeOutCubic,
            left: smallLeft,
            top: smallTop,
            child: IgnorePointer(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: isVisible ? 1 : 0,
                child: Container(
                  width: smallSize,
                  height: smallSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryOrange.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
