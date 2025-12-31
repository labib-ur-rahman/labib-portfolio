import 'package:flutter/material.dart';
import '../../../core/core.dart';

class HelloBadge extends StatelessWidget {
  final String text;

  const HelloBadge({super.key, this.text = AppStrings.greeting});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.49,
            vertical: 12.745,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundGlass,
            borderRadius: BorderRadius.circular(38.235),
            border: Border.all(color: AppColors.borderDark, width: 1.275),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontSize: AppDimensions.fontSizeM,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ),
        // Decorative wave icon positioned at top right
        Positioned(top: -10, right: -15, child: _buildWaveIcon()),
      ],
    );
  }

  Widget _buildWaveIcon() {
    return CustomPaint(
      size: const Size(27.5, 28.5),
      painter: WaveIconPainter(),
    );
  }
}

class WaveIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryOrangeLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Drawing wave/sparkle lines
    final path1 = Path()
      ..moveTo(size.width * 0.3, size.height * 0.1)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.3,
        size.width * 0.3,
        size.height * 0.5,
      );

    final path2 = Path()
      ..moveTo(size.width * 0.5, size.height * 0.0)
      ..lineTo(size.width * 0.5, size.height * 0.4);

    final path3 = Path()
      ..moveTo(size.width * 0.7, size.height * 0.1)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.3,
        size.width * 0.7,
        size.height * 0.5,
      );

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
