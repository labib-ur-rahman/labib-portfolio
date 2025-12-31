import 'package:flutter/material.dart';
import '../../../core/core.dart';

class QuoteSection extends StatelessWidget {
  final String quoteText;

  const QuoteSection({super.key, required this.quoteText});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Quote Icon
        CustomPaint(
          size: Size(isDesktop ? 36 : 28, isDesktop ? 36 : 28),
          painter: QuoteIconPainter(),
        ),
        SizedBox(height: isDesktop ? 24 : 16),
        // Quote Text
        Text(
          quoteText,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: isMobile ? 14 : (isDesktop ? 20 : 16),
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
            letterSpacing: -0.3,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class QuoteIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryOrange
      ..style = PaintingStyle.fill;

    // Left quote mark
    final leftQuotePath = Path()
      ..moveTo(size.width * 0.0, size.height * 0.3)
      ..quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.0,
        size.width * 0.35,
        size.height * 0.15,
      )
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.4,
        size.width * 0.15,
        size.height * 0.7,
      )
      ..quadraticBezierTo(
        size.width * 0.0,
        size.height * 0.5,
        size.width * 0.0,
        size.height * 0.3,
      );

    // Right quote mark
    final rightQuotePath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.3)
      ..quadraticBezierTo(
        size.width * 0.65,
        size.height * 0.0,
        size.width * 0.85,
        size.height * 0.15,
      )
      ..quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.4,
        size.width * 0.65,
        size.height * 0.7,
      )
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.5,
        size.width * 0.5,
        size.height * 0.3,
      );

    canvas.drawPath(leftQuotePath, paint);
    canvas.drawPath(rightQuotePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
