import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  _buildAboutSection(context, controller, constraints),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAboutSection(
    BuildContext context,
    AboutController controller,
    BoxConstraints constraints,
  ) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background and main content
          Column(
            children: [
              // Navbar
              Padding(
                padding: EdgeInsets.only(
                  top: isMobile ? 16 : 20,
                  left: isMobile ? 16 : 20,
                  right: isMobile ? 16 : 20,
                ),
                child: _buildNavbar(context, controller),
              ),

              // Hero Section
              SizedBox(height: isMobile ? 20 : 37),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : (isTablet ? 40 : 71),
                ),
                child: _buildHeroSection(context, controller),
              ),
            ],
          ),

          // CTA Buttons at bottom
          Positioned(
            bottom: isMobile ? 20 : 40,
            child: Obx(
              () => AnimatedOpacity(
                opacity: controller.showContent.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: _buildCtaButtons(context, controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar(BuildContext context, AboutController controller) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    if (isMobile) {
      return _buildMobileNavbar(context, controller);
    }

    return Obx(
      () => AnimatedOpacity(
        opacity: controller.showContent.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: AnimatedSlide(
          offset: controller.showContent.value
              ? Offset.zero
              : const Offset(0, -1),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          child: GlassContainer(
            width: isDesktop ? null : null,
            constraints: isDesktop
                ? const BoxConstraints(maxWidth: 1298)
                : null,
            height: 86,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: AppColors.gray900,
            borderColor: AppColors.borderLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Home button (active)
                Flexible(
                  child: NavItem(
                    title: AppStrings.navHome,
                    isSelected: controller.selectedNavIndex.value == 0,
                    onTap: () => controller.onNavItemTap(0),
                  ),
                ),
                Flexible(
                  child: NavItem(
                    title: AppStrings.navAbout,
                    isSelected: controller.selectedNavIndex.value == 1,
                    onTap: () => controller.onNavItemTap(1),
                  ),
                ),
                Flexible(
                  child: NavItem(
                    title: AppStrings.navService,
                    isSelected: controller.selectedNavIndex.value == 2,
                    onTap: () => controller.onNavItemTap(2),
                  ),
                ),
                // Logo in center
                _buildLogo(context),
                Flexible(
                  child: NavItem(
                    title: AppStrings.navResume,
                    isSelected: controller.selectedNavIndex.value == 3,
                    onTap: () => controller.onNavItemTap(3),
                  ),
                ),
                Flexible(
                  child: NavItem(
                    title: AppStrings.navProject,
                    isSelected: controller.selectedNavIndex.value == 4,
                    onTap: () => controller.onNavItemTap(4),
                  ),
                ),
                Flexible(
                  child: NavItem(
                    title: AppStrings.navContact,
                    isSelected: controller.selectedNavIndex.value == 5,
                    onTap: () => controller.onNavItemTap(5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavbar(BuildContext context, AboutController controller) {
    return Obx(
      () => AnimatedOpacity(
        opacity: controller.showContent.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: GlassContainer(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: AppColors.gray900,
          borderColor: AppColors.borderLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              _buildLogo(context, isMobile: true),
              // Menu Icon
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.textWhite,
                  size: 28,
                ),
                onPressed: () {
                  // Show mobile menu
                  _showMobileMenu(context, controller);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, AboutController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.gray900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              controller.navItems.length,
              (index) => ListTile(
                title: Text(
                  controller.navItems[index],
                  style: TextStyle(
                    color: controller.selectedNavIndex.value == index
                        ? AppColors.primaryOrange
                        : AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: controller.selectedNavIndex.value == index
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
                onTap: () {
                  controller.onNavItemTap(index);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, {bool isMobile = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 10 : 20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo Icon
          Container(
            width: isMobile ? 36 : 46,
            height: isMobile ? 36 : 46,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'LR',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: isMobile ? 14 : 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Logo Text
          Text(
            'LABIB',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textWhite,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, AboutController controller) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Main content column
          Column(
            children: [
              // Hello Badge and Title
              Obx(
                () => AnimatedOpacity(
                  opacity: controller.showContent.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedSlide(
                    offset: controller.showContent.value
                        ? Offset.zero
                        : const Offset(0, 0.3),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    child: Column(
                      children: [
                        const HelloBadge(),
                        SizedBox(height: isMobile ? 16 : 10),
                        _buildMainTitle(context),
                      ],
                    ),
                  ),
                ),
              ),

              // Profile Image with Orange Background
              SizedBox(height: isMobile ? 20 : 0),
              Obx(
                () => AnimatedOpacity(
                  opacity: controller.showProfile.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: AnimatedSlide(
                    offset: controller.showProfile.value
                        ? Offset.zero
                        : const Offset(0, 0.2),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    child: _buildProfileSection(context),
                  ),
                ),
              ),
            ],
          ),

          // Left Quote Section
          if (!isMobile)
            Positioned(
              left: 0,
              top: isDesktop ? 280 : 200,
              child: Obx(
                () => AnimatedOpacity(
                  opacity: controller.showDecorations.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedSlide(
                    offset: controller.showDecorations.value
                        ? Offset.zero
                        : const Offset(-0.5, 0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    child: const QuoteSection(
                      quoteText: AppStrings.testimonialText,
                    ),
                  ),
                ),
              ),
            ),

          // Right Experience Section
          if (!isMobile)
            Positioned(
              right: 0,
              top: isDesktop ? 290 : 210,
              child: Obx(
                () => AnimatedOpacity(
                  opacity: controller.showDecorations.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedSlide(
                    offset: controller.showDecorations.value
                        ? Offset.zero
                        : const Offset(0.5, 0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    child: const ExperienceCard(
                      years: AppStrings.yearsExperience,
                      label: AppStrings.experienceLabel,
                    ),
                  ),
                ),
              ),
            ),

          // Decorative sparkle left
          if (isDesktop)
            Positioned(
              left: 30,
              top: 180,
              child: Obx(
                () => AnimatedOpacity(
                  opacity: controller.showDecorations.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: const FloatingSparkle(
                    size: 80,
                    color: AppColors.primaryOrangeLight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainTitle(BuildContext context) {
    final isTablet = ResponsiveUtils.isTablet(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    final fontSize = isMobile ? 40.0 : (isTablet ? 65.0 : 95.566);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -1.4335,
          height: 1.0,
        ),
        children: const [
          TextSpan(text: "I'm "),
          TextSpan(
            text: 'Labibur',
            style: TextStyle(color: AppColors.primaryOrange),
          ),
          TextSpan(text: ',\nFlutter Developer'),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final isTablet = ResponsiveUtils.isTablet(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final profileWidth = isMobile
        ? screenWidth * 0.9
        : (isTablet ? 600.0 : 952.402);
    final profileHeight = isMobile
        ? screenWidth * 0.9 * 0.667
        : (isTablet ? 400.0 : 636.0);
    final ellipseWidth = isMobile
        ? screenWidth * 0.7
        : (isTablet ? 500.0 : 811.779);
    final ellipseHeight = isMobile
        ? screenWidth * 0.35
        : (isTablet ? 250.0 : 405.889);

    return SizedBox(
      width: profileWidth,
      height: profileHeight + 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Orange Ellipse Background
          Positioned(
            bottom: 0,
            child: OrangeEllipse(width: ellipseWidth, height: ellipseHeight),
          ),

          // Profile Image
          Positioned(
            bottom: 0,
            child: Container(
              width: profileWidth,
              height: profileHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&h=1000&fit=crop&crop=face',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.gray300,
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 200,
                          color: AppColors.gray700,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.gray300.withValues(alpha: 0.3),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaButtons(BuildContext context, AboutController controller) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return GlassContainer(
      width: isMobile ? 300 : 367,
      height: isMobile ? 70 : 82,
      padding: const EdgeInsets.all(10),
      backgroundColor: AppColors.backgroundGlass,
      borderColor: AppColors.borderLight,
      child: Row(
        children: [
          PrimaryButton(
            text: AppStrings.resumeBtn,
            width: isMobile ? 160 : 208,
            onPressed: controller.onPortfolioTap,
          ),
          Expanded(
            child: SecondaryButton(
              text: AppStrings.myWorkBtn,
              onPressed: controller.onHireMeTap,
            ),
          ),
        ],
      ),
    );
  }
}
