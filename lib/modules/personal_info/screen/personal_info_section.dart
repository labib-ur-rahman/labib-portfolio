import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';

class PersonalInfoSection extends StatefulWidget {
  const PersonalInfoSection({super.key});

  @override
  State<PersonalInfoSection> createState() => _PersonalInfoSectionState();
}

class _PersonalInfoSectionState extends State<PersonalInfoSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInfoController());
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            bottom: isMobile ? 0 : 20,
            left: isMobile ? 0 : 20,
            right: isMobile ? 0 : 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isMobile ? 20 : 40),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.gray900,
                AppColors.gray900.withValues(alpha: 0.95),
              ],
            ),
            boxShadow: isMobile
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
          ),
          child: Stack(
            children: [
              // Background Pattern
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 0 : 40),
                  child: Opacity(
                    opacity: 0.03,
                    child: CustomPaint(painter: _DotPatternPainter()),
                  ),
                ),
              ),

              // Decorative Gradient Orbs
              if (!isMobile) ...[
                Positioned(
                  top: -30,
                  left: -20,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primaryOrange.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -70,
                  right: -50,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primaryOrange.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              // Main Content
              Padding(
                padding: EdgeInsets.only(
                  left: isMobile ? 24 : (isTablet ? 50 : 80),
                  right: isMobile ? 24 : (isTablet ? 50 : 80),
                  top: isMobile ? 50 : (isTablet ? 70 : 90),
                  bottom: isMobile ? 30 : (isTablet ? 50 : 70),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isMobile, isTablet),
                    SizedBox(height: isMobile ? 40 : 60),
                    if (isMobile)
                      _buildMobileLayout(controller)
                    else
                      _buildDesktopLayout(controller, isTablet),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isTablet) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 36 : (isTablet ? 44 : 52),
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
                height: 1.1,
              ),
              children: const [
                TextSpan(
                  text: 'Personal ',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Information',
                  style: TextStyle(color: AppColors.primaryOrange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: isMobile ? 60 : 80,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryOrange,
                  AppColors.primaryOrange.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(PersonalInfoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutMe(controller, true),
        const SizedBox(height: 20),
        _buildPersonalDetailsGrid(controller, true, false),
      ],
    );
  }

  Widget _buildDesktopLayout(PersonalInfoController controller, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isTablet ? 5 : 6,
          child: _buildAboutMe(controller, false),
        ),
        SizedBox(width: isTablet ? 50 : 80),
        Expanded(
          flex: isTablet ? 5 : 4,
          child: _buildPersonalDetailsGrid(controller, false, isTablet),
        ),
      ],
    );
  }

  Widget _buildAboutMe(PersonalInfoController controller, bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gray800.withValues(alpha: 0.4),
              AppColors.gray800.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primaryOrange.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.solidAddressCard,
                    color: AppColors.primaryOrange,
                    size: isMobile ? 20 : 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'About Me',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              controller.aboutMe,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 15 : 17,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.85),
                letterSpacing: -0.2,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalDetailsGrid(
    PersonalInfoController controller,
    bool isMobile,
    bool isTablet,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 30 : 30),
      child: Image.asset(AppAssets.labibProfile, fit: BoxFit.cover),
    );
  }
}

// Custom painter for dot pattern background
class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const spacing = 30.0;
    const dotRadius = 1.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
