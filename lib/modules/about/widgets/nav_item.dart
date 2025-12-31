import 'package:flutter/material.dart';
import '../../../core/core.dart';

class NavItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const NavItem({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.primaryOrange
                  : (_isHovered
                        ? AppColors.primaryOrange.withValues(alpha: 0.1)
                        : Colors.transparent),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: AppDimensions.fontSizeM,
                fontWeight: widget.isSelected
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: AppColors.textWhite,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
