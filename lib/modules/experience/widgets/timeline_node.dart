import 'package:flutter/material.dart';
import '../../../core/core.dart';

class TimelineNode extends StatelessWidget {
  final bool isActive;
  final bool isFirst;
  final bool isLast;

  const TimelineNode({
    super.key,
    this.isActive = false,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final nodeSize = isMobile ? 36.0 : 48.0;

    return SizedBox(
      width: nodeSize,
      child: Column(
        children: [
          // Top line
          if (!isFirst)
            Container(
              width: 2,
              height: isMobile ? 40 : 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.gray700,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: CustomPaint(painter: DashedLinePainter()),
            ),

          // Node circle
          Container(
            width: nodeSize,
            height: nodeSize,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryOrange : AppColors.gray900,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppColors.primaryOrange : AppColors.gray700,
                width: 2,
              ),
            ),
            child: isActive
                ? const Center(
                    child: Icon(Icons.check, color: Colors.white, size: 20),
                  )
                : null,
          ),

          // Bottom line
          if (!isLast)
            Container(
              width: 2,
              height: isMobile ? 40 : 60,
              child: CustomPaint(painter: DashedLinePainter()),
            ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gray700
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashHeight = 5.0;
    const dashSpace = 5.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
