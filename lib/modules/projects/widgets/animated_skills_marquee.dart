import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class AnimatedSkillsMarquee extends StatefulWidget {
  const AnimatedSkillsMarquee({super.key});

  @override
  State<AnimatedSkillsMarquee> createState() => _AnimatedSkillsMarqueeState();
}

class _AnimatedSkillsMarqueeState extends State<AnimatedSkillsMarquee> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;

  final List<String> skills = [
    'UX Design',
    'App Design',
    'Dashboard',
    'Wireframe',
    'User Research',
    'UX Design',
    'App Design',
    'Dashboard',
    'Wireframe',
    'User Research',
    'UX Design',
    'App Design',
    'Dashboard',
    'Wireframe',
    'User Research',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Start auto-scrolling after a small delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        // Smoothly scroll
        final nextScroll = currentScroll + 1.0;

        // Reset to beginning when reaching the end for infinite loop
        if (nextScroll >= maxScroll / 2) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(nextScroll);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.044, // About -2.5 degrees (357.5 degrees in the design)
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            ...List.generate(skills.length * 2, (index) {
              final skill = skills[index % skills.length];
              return _buildSkillItem(skill);
            }),
          ],
        ),
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
