import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedSkillsMarquee extends StatefulWidget {
  const AnimatedSkillsMarquee({super.key});

  @override
  State<AnimatedSkillsMarquee> createState() => _AnimatedSkillsMarqueeState();
}

class _AnimatedSkillsMarqueeState extends State<AnimatedSkillsMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<String> skills = [
    'Play Store',
    'App Store',
    'Google Maps',
    'Flutter',
    'Dart',
    'REST APIs',
    'Firebase',
    'Firestore',
    'Realtime Database',
    'Cloud Functions',
    'FCM',
    'Kotlin',
    'Java',
    'XML',
    'Git',
    'GitHub',
    'Figma',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 90),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.044,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipRect(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return child!;
                },
              ),
            );
          },
          child: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.centerLeft,
            child: _MarqueeContent(controller: _controller, skills: skills),
          ),
        ),
      ),
    );
  }
}

class _MarqueeContent extends AnimatedWidget {
  final List<String> skills;

  const _MarqueeContent({
    required AnimationController controller,
    required this.skills,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as AnimationController;
    // We build items in a Row, translate by animation value
    return FractionalTranslation(
      translation: Offset(-animation.value, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(skills.length * 3, (index) {
            final skill = skills[index % skills.length];
            return _buildSkillItem(skill);
          }),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            skill,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: -0.72,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 15),
          _buildStarIcon(),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _buildStarIcon() {
    return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CustomPaint(size: const Size(20, 20), painter: StarPainter()),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB6514)
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = size.width / 2;
    final innerRadius = size.width / 4;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45 - 90) * 3.14159 / 180;
      final radius = i % 2 == 0 ? outerRadius : innerRadius;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
