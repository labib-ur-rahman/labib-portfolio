import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SkillsController());
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Obx(
      () => AnimatedOpacity(
        opacity: controller.showContent.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        child: AnimatedSlide(
          offset: controller.showContent.value
              ? Offset.zero
              : const Offset(0, 0.1),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFFF2F4F7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 71,
                vertical: isMobile ? 60 : 122,
              ),
              child: SizedBox(
                width: isMobile ? double.infinity : 1299,
                child: isMobile
                    ? _buildMobileLayout(context, controller)
                    : _buildDesktopLayout(context, controller, isTablet),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, SkillsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        const SizedBox(height: 20),
        _buildDescription(context),
        const SizedBox(height: 30),
        _buildStats(context, controller),
        const SizedBox(height: 40),
        _buildSkillsGrid(context, controller),
        const SizedBox(height: 40),
        _buildHireButton(context),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    SkillsController controller,
    bool isTablet,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Decorative circles and image placeholder
        Expanded(
          flex: isTablet ? 2 : 3,
          child: _buildDecorativeSection(context),
        ),
        SizedBox(width: isTablet ? 40 : 96),

        // Right side - Content
        Expanded(
          flex: isTablet ? 8 : 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              const SizedBox(height: 47),
              _buildDescription(context),
              const SizedBox(height: 40),
              _buildStats(context, controller),
              const SizedBox(height: 47),
              _buildSkillsGrid(context, controller),
              const SizedBox(height: 40),
              _buildHireButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeSection(BuildContext context) {
    return Container(
      height: 600,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Concentric circles with blur effect
          ..._buildConcentricCircles(),

          // Center content - Profile image placeholder
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryOrange.withValues(alpha: 0.3),
                    AppColors.primaryOrangeLight.withValues(alpha: 0.2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryOrange.withValues(alpha: 0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    // Skils Icons
                    child: Icon(
                      Icons.code,
                      size: 80,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildConcentricCircles() {
    final circles = <Widget>[];
    final sizes = [314.0, 314.0, 294.0, 270.0, 244.0, 218.0, 192.0];
    final colors = [
      AppColors.primaryOrange.withValues(alpha: 0.05),
      AppColors.primaryOrange.withValues(alpha: 0.08),
      AppColors.primaryOrange.withValues(alpha: 0.1),
      AppColors.primaryOrange.withValues(alpha: 0.12),
      AppColors.primaryOrange.withValues(alpha: 0.15),
      AppColors.primaryOrange.withValues(alpha: 0.18),
      AppColors.primaryOrange.withValues(alpha: 0.2),
    ];

    for (int i = 0; i < sizes.length; i++) {
      circles.add(
        Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 800 + (i * 100)),
            curve: Curves.easeOutCubic,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: sizes[i],
                  height: sizes[i],
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors[i], width: 2),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return circles;
  }

  Widget _buildTitle(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: isMobile ? 36 : (isTablet ? 48 : 64),
          fontWeight: FontWeight.w600,
          letterSpacing: -0.96,
          height: 1.0,
        ),
        children: const [
          TextSpan(
            text: 'My ',
            style: TextStyle(color: AppColors.gray700),
          ),
          TextSpan(
            text: 'Skills',
            style: TextStyle(color: AppColors.primaryOrange),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Text(
      'I bring 5+ years of mobile development expertise with Flutter, creating high-performance apps with clean architecture and beautiful UI/UX design.',
      style: TextStyle(
        fontFamily: 'Urbanist',
        fontSize: isMobile ? 14 : 20,
        fontWeight: FontWeight.w400,
        color: AppColors.gray400,
        letterSpacing: -0.3,
        height: 1.5,
      ),
    );
  }

  Widget _buildStats(BuildContext context, SkillsController controller) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Row(
      children: controller.stats.asMap().entries.map((entry) {
        final index = entry.key;
        final stat = entry.value;
        return Expanded(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 600 + (index * 200)),
            curve: Curves.easeOutBack,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat.count,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: isMobile ? 28 : 36,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1D2939),
                        letterSpacing: -0.54,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      stat.label,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: isMobile ? 14 : 20,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF667085),
                        letterSpacing: -0.3,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, SkillsController controller) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : (isTablet ? 2 : 3),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: isMobile ? 120 : (isTablet ? 130 : 120),
      ),
      itemCount: controller.skills.length,
      itemBuilder: (context, index) {
        final skill = controller.skills[index];
        return SkillCard(
          skillName: skill.name,
          level: skill.level,
          category: skill.category,
          index: index,
          icon: skill.icon,
        );
      },
    );
  }

  Widget _buildHireButton(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Handle hire me action
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 40 : 59,
                  vertical: isMobile ? 20 : 33,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF151515), width: 1),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  'Hire me',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF151515),
                    letterSpacing: -0.48,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
