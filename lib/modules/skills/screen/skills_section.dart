import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
              padding: EdgeInsets.only(
                left: isMobile ? 24 : 71,
                right: isMobile ? 24 : 71,
                top: isMobile ? 60 : 122,
                bottom: isMobile
                    ? 0
                    : isTablet
                    ? 0
                    : 122,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: isMobile ? double.infinity : 1299,
                    child: isMobile
                        ? _buildMobileLayout(context, controller)
                        : _buildDesktopLayout(context, controller, isTablet),
                  ),
                ],
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
        Center(
          child: Positioned(
            child: Lottie.asset(
              'assets/lottie/Programming-Computer.json',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    SkillsController controller,
    bool isTablet,
  ) {
    /// -- Tablet Layout --
    if (isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: 47),
          _buildDescription(context),
          const SizedBox(height: 40),
          _buildStats(context, controller),
          const SizedBox(height: 47),
          _buildSkillsGrid(context, controller),
          Center(
            child: Positioned(
              child: Lottie.asset(
                'assets/lottie/Programming-Computer.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      );
    }

    /// -- Desktop Layout --
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = isTablet ? 28.0 : 48.0;
        final contentWidth = constraints.maxWidth * 0.6;
        final lottieWidth = isTablet ? constraints.maxWidth * 0.6 : 650.0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Left side - Decorative circles and image placeholder
            Positioned(
              left: -100,
              child: SizedBox(
                width: lottieWidth,
                child: Lottie.asset(
                  'assets/lottie/Programming-Computer.json',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Right side - Content (60%)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: gap),
                child: SizedBox(
                  width: contentWidth,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
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
}
