import 'package:flutter/material.dart';
import '../../../core/core.dart';

class DecorativeElements extends StatelessWidget {
  const DecorativeElements({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(100, 100), painter: SparklesPainter());
  }
}

class SparklesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryOrangeLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Draw decorative sparkle lines
    // Line 1
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.5),
      paint,
    );

    // Line 2
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.2),
      Offset(size.width * 0.3, size.height * 0.6),
      paint,
    );

    // Curved line
    final path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.2)
      ..quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.4,
        size.width * 0.5,
        size.height * 0.6,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FloatingSparkle extends StatefulWidget {
  final double size;
  final Color color;

  const FloatingSparkle({
    super.key,
    this.size = 60,
    this.color = AppColors.primaryOrangeLight,
  });

  @override
  State<FloatingSparkle> createState() => _FloatingSparkleState();
}

class _FloatingSparkleState extends State<FloatingSparkle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: StarSparkPainter(color: widget.color),
      ),
    );
  }
}

class StarSparkPainter extends CustomPainter {
  final Color color;

  StarSparkPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;

    // Draw cross lines from center
    canvas.drawLine(
      Offset(center.dx, center.dy - radius * 0.8),
      Offset(center.dx, center.dy + radius * 0.8),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - radius * 0.8, center.dy),
      Offset(center.dx + radius * 0.8, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
