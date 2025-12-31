import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/core.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool showArrow;
  final double? width;
  final double? height;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.showArrow = true,
    this.width,
    this.height,
    this.isOutlined = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final fontSize = isDesktop ? AppDimensions.fontSizeL : 18.0;

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
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 20 : 16,
              vertical: isDesktop ? 10 : 8,
            ),
            decoration: BoxDecoration(
              color: widget.isOutlined
                  ? Colors.transparent
                  : (_isHovered
                        ? AppColors.primaryOrangeLight
                        : AppColors.primaryOrange),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              border: widget.isOutlined
                  ? Border.all(color: AppColors.gray300, width: 0.5)
                  : Border.all(color: AppColors.gray300, width: 0.5),
              boxShadow: _isHovered && !widget.isOutlined
                  ? [
                      BoxShadow(
                        color: AppColors.primaryOrange.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: widget.isOutlined
                        ? AppColors.textWhite
                        : AppColors.textWhite,
                    letterSpacing: -0.3854,
                  ),
                ),
                if (widget.showArrow) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Iconsax.arrow_right_1,
                    color: AppColors.textWhite,
                    size: isDesktop ? 24 : 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({super.key, required this.text, this.onPressed});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final fontSize = isDesktop ? AppDimensions.fontSizeL : 18.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 20 : 16,
            vertical: isDesktop ? 10 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            color: _isHovered
                ? AppColors.primaryOrange.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
              color: AppColors.textWhite,
              letterSpacing: -0.3854,
            ),
          ),
        ),
      ),
    );
  }
}
