import 'package:flutter/material.dart';
import '../../../core/core.dart';

class PageIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final ValueChanged<int>? onTap;

  const PageIndicator({
    super.key,
    required this.totalPages,
    required this.currentPage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) => GestureDetector(
          onTap: () => onTap?.call(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5.655),
            width: index == currentPage ? 60.324 : 15.081,
            height: 15.081,
            decoration: BoxDecoration(
              color: index == currentPage
                  ? AppColors.primaryOrange
                  : const Color(0xFFE4E7EC),
              borderRadius: BorderRadius.circular(20.736),
            ),
          ),
        ),
      ),
    );
  }
}
