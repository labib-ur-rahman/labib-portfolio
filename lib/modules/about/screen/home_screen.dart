import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio/modules/projects/widgets/animated_skills_marquee.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';
import '../../personal_info/screen/screen.dart';
import '../../experience/screen/screen.dart';
import '../../skills/screen/screen.dart';
import '../../projects/screen/screen.dart';
import '../../services/screen/screen.dart';
import '../../contact_me/screen/contact_me_section.dart';
import '../../footer/screen/footer_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = ResponsiveUtils.isMobile(context);
          final isTablet = ResponsiveUtils.isTablet(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                Container(
                  // decoration: BoxDecoration(color: Colors.amberAccent),
                  key: controller.aboutKey,
                  child: _buildHeroSection(context, controller, constraints),
                ),

                // About Section
                const PersonalInfoSection(),

                const SizedBox(height: 40),

                // Work Experience Section
                Container(
                  key: controller.experienceKey,
                  child: const ExperienceSection(),
                ),

                const SizedBox(height: 40),

                // Skills Section
                Container(
                  key: controller.skillsKey,
                  child: const SkillsSection(),
                ),

                // SizedBox(height: isMobile ? 20 : 30),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : (isTablet ? 60 : 80),
                    vertical: isMobile ? 20 : (isTablet ? 30 : 40),
                  ),
                  child: _buildAnimatedSkillsBanner(),
                ),

                // const SizedBox(he  ight: 40),

                // Projects Section
                const ProjectsSection(),

                const SizedBox(height: 40),

                // My Services Section
                Container(
                  key: controller.servicesKey,
                  child: const ServicesSection(),
                ),

                const SizedBox(height: 60),

                // Contact Me Section
                const ContactMeSection(),

                // Footer Section
                const FooterSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedSkillsBanner() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryOrange, const Color(0xFFFB6514)],
        ),
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(24),
        //   bottomRight: Radius.circular(24),
        // ),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: const AnimatedSkillsMarquee(),
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    AboutController controller,
    BoxConstraints constraints,
  ) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    // final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      // constraints: BoxConstraints(minHeight: screenHeight),
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
                child: _buildOnlyHeroSection(context, controller),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar(BuildContext context, AboutController controller) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    if (isMobile || isTablet) {
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
            // constraints: BoxConstraints(maxWidth: isTablet ? 900 : 1298),
            height: 86,
            margin: const EdgeInsets.symmetric(horizontal: 60),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: AppColors.gray900,
            borderColor: AppColors.borderLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                _buildLogo(context),

                // Navigation Items
                Row(
                  children: List.generate(
                    controller.navItems.length,
                    (index) => _buildModernNavItem(
                      context,
                      controller,
                      index,
                      controller.navItems[index],
                    ),
                  ),
                ),

                // Theme Toggle Button
                _buildThemeToggle(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernNavItem(
    BuildContext context,
    AboutController controller,
    int index,
    String title,
  ) {
    return Obx(() {
      final isSelected = controller.selectedNavIndex.value == index;
      final isHovered = controller.hoveredNavIndex.value == index;

      return MouseRegion(
        onEnter: (_) => controller.onNavHover(index),
        onExit: (_) => controller.clearNavHover(),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => controller.onNavItemTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryOrange.withValues(alpha: 0.1)
                  : isHovered
                  ? AppColors.gray900.withValues(alpha: 0.5)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryOrange
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? AppColors.primaryOrange
                    : isHovered
                    ? AppColors.textWhite
                    : AppColors.gray400,
                letterSpacing: 0.5,
              ),
              child: Text(title),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildThemeToggle(BuildContext context, AboutController controller) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.gray900.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight, width: 1),
        ),
        child: IconButton(
          icon: Icon(
            controller.themeController.isDarkMode.value
                ? Iconsax.sun_1
                : Iconsax.moon,
            color: AppColors.primaryOrange,
            size: 20,
          ),
          onPressed: () => controller.themeController.toggleTheme(),
          tooltip: 'Toggle Theme',
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
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: AppColors.gray900,
          borderColor: AppColors.borderLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(context, isMobile: true),
              Row(
                children: [
                  // Theme Toggle
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray900.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.borderLight,
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        controller.themeController.isDarkMode.value
                            ? Iconsax.sun_1
                            : Iconsax.moon,
                        color: AppColors.primaryOrange,
                        size: 20,
                      ),
                      onPressed: () => controller.themeController.toggleTheme(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Menu Button
                  IconButton(
                    icon: const Icon(
                      Iconsax.menu,
                      color: AppColors.textWhite,
                      size: 28,
                    ),
                    onPressed: () => _showMobileMenu(context, controller),
                  ),
                ],
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
      builder: (context) => Obx(
        () => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.close_circle,
                      color: AppColors.textWhite,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...List.generate(
                controller.navItems.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: controller.selectedNavIndex.value == index
                        ? AppColors.primaryOrange.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.selectedNavIndex.value == index
                          ? AppColors.primaryOrange
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      controller.navItems[index],
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: controller.selectedNavIndex.value == index
                            ? AppColors.primaryOrange
                            : AppColors.textWhite,
                        fontSize: 18,
                        fontWeight: controller.selectedNavIndex.value == index
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    trailing: controller.selectedNavIndex.value == index
                        ? const Icon(
                            Iconsax.tick_circle,
                            color: AppColors.primaryOrange,
                          )
                        : null,
                    onTap: () {
                      controller.onNavItemTap(index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
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
          Container(
            width: isMobile ? 36 : 46,
            height: isMobile ? 36 : 46,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.vector,
                width: isMobile ? 20 : 24,
                height: isMobile ? 20 : 24,
              ),
            ),
          ),
          const SizedBox(width: 10),
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

  Widget _buildOnlyHeroSection(
    BuildContext context,
    AboutController controller,
  ) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Hello Badge and Title
              Stack(
                children: [
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
                            SizedBox(height: isMobile ? 30 : 10),
                            _buildHelloBadge(context),
                            SizedBox(height: isMobile ? 24 : 10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 60,
                              ),
                              child: _buildMainTitle(context),
                            ),
                            SizedBox(height: isMobile ? 30 : 50),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Decorative sparkle
                  // if (!isMobile)
                  Positioned(
                    bottom: isMobile ? 10 : 0,
                    left: isMobile ? 20 : null,
                    // top: 20,
                    child: Obx(
                      () => AnimatedOpacity(
                        opacity: controller.showDecorations.value ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 800),
                        child: _buildDecorativeSparkle(context),
                      ),
                    ),
                  ),
                ],
              ),

              // Profile Image with Orange Background
              SizedBox(height: isMobile ? 40 : 50),
              Stack(
                children: [
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
                        child: _buildProfileSection(context, controller),
                      ),
                    ),
                  ),
                ],
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
                    child: _buildQuoteSection(context),
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
                    child: _buildExperienceCard(context),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHelloBadge(BuildContext context) {
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
          child: const Text(
            'Hello!',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 20, // Figma: 20px
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ),
        // Decorative wave
        Positioned(
          top: -20,
          right: -15,
          child: SvgPicture.asset(
            AppAssets.vector1,
            width: 27.5,
            height: 28.5,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryOrangeLight,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainTitle(BuildContext context) {
    final isTablet = ResponsiveUtils.isTablet(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    // Improved mobile font size for better readability
    final fontSize = isMobile ? 52.0 : (isTablet ? 52.0 : 92.0);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: isMobile ? -0.8 : -1.4335,
          height: isMobile ? 1.2 : 1.0,
        ),
        children: const [
          TextSpan(text: "It's "),
          TextSpan(
            text: 'Labibur',
            style: TextStyle(color: AppColors.primaryOrange),
          ),
          TextSpan(text: ',\nJr. Flutter Developer'),
        ],
      ),
    );
  }

  Widget _buildQuoteSection(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Quote Icon
        SvgPicture.asset(
          AppAssets.quoteIcon,
          width: isDesktop ? 36 : 28,
          height: isDesktop ? 36 : 28,
        ),
        SizedBox(height: isDesktop ? 24 : 16),
        // Quote Text - Figma: 20px
        Text(
          AppStrings.testimonialText,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: isDesktop ? 20 : 16, // Figma: 20px
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
            letterSpacing: -0.3,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Star Rating
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 2),
              child: SvgPicture.asset(
                AppAssets.star,
                width: isDesktop ? 26 : 20,
                height: isDesktop ? 26 : 20,
              ),
            ),
          ),
        ),
        // Years - Figma: 47px
        Text(
          AppStrings.yearsExperience,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: isDesktop ? 47 : 36, // Figma: 47px
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.705,
          ),
        ),
        const SizedBox(height: 5),
        // Label - Figma: 20px
        Text(
          AppStrings.experienceLabel,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: isDesktop ? 20 : 16, // Figma: 20px
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeSparkle(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return SvgPicture.asset(
      AppAssets.vector2,
      width: isMobile ? 40 : 80,
      height: isMobile ? 40 : 80,
      colorFilter: const ColorFilter.mode(
        AppColors.primaryOrangeLight,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    AboutController controller,
  ) {
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
      height: isMobile
          ? profileHeight - 120
          : (isTablet)
          ? profileHeight - 150
          : profileHeight - 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Orange Ellipse Background using SVG
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              AppAssets.ellipse2,
              width: ellipseWidth,
              height: ellipseHeight,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryOrangeLight,
                BlendMode.srcIn,
              ),
            ),
          ),

          // Profile Image from assets
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: profileWidth,
              height: profileHeight,
              child: Image.asset(
                AppAssets.youngPrettyWoman,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.gray300,
                    child: const Center(
                      child: Icon(
                        Iconsax.user,
                        size: 200,
                        color: AppColors.gray700,
                      ),
                    ),
                  );
                },
              ),
            ),
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

  Widget _buildCtaButtons(BuildContext context, AboutController controller) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return GlassContainer(
      width: isMobile ? 300 : 400,
      height: isMobile ? 70 : 80,
      padding: const EdgeInsets.all(10),
      backgroundColor: AppColors.backgroundGlass,
      borderColor: AppColors.borderLight,
      child: Row(
        children: [
          // Portfolio Button
          Expanded(flex: 2, child: _buildPortfolioButton(context, controller)),
          // const SizedBox(width: 10),
          // Hire Me Button
          Expanded(child: _buildHireMeButton(context, controller)),
        ],
      ),
    );
  }

  Widget _buildPortfolioButton(
    BuildContext context,
    AboutController controller,
  ) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: controller.onPortfolioTap,
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 8 : 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange,
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: AppColors.gray300, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.resumeBtn,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: isMobile ? 16 : 22, // Figma: 25.692px
                  fontWeight: FontWeight.w500,
                  color: AppColors.textWhite,
                  letterSpacing: -0.3854,
                ),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                AppAssets.upRight,
                width: isMobile ? 24 : 42,
                height: isMobile ? 24 : 42,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHireMeButton(BuildContext context, AboutController controller) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: controller.onHireMeTap,
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 8 : 10,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          child: Text(
            isMobile ? AppStrings.workBtn : AppStrings.myWorkBtn,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: isMobile ? 18 : 22, // Figma: 25.692px
              fontWeight: FontWeight.w300,
              color: AppColors.textWhite,
              letterSpacing: -0.3854,
            ),
          ),
        ),
      ),
    );
  }
}
