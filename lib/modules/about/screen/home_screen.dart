import 'package:DeveloperLabib/core/utils/cursor_follower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:DeveloperLabib/modules/projects/widgets/animated_skills_marquee.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';
import '../../personal_info/screen/screen.dart';
import '../../experience/screen/screen.dart';
import '../../skills/screen/modern_skills_section.dart';
import '../../projects/screen/screen.dart';
import '../../contact_me/screen/contact_me_section.dart';
import '../../contact_me/screen/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _logoImageUrl =
      'https://i.ibb.co.com/Zp4KGZmk/L-logo.png';
  static const String _labibPortfolioImageUrl =
      'https://i.ibb.co.com/wZqFKNL6/labib-portfolio-transparent.png';
  static const String _labibProfileImageUrl =
      'https://i.ibb.co.com/84rFpH5X/labib-profile-squre.png';

  static const double _contactOverlap = 40;
  static const double _cursorFollowerSize = 48;
  final GlobalKey _cursorRegionKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  double _contactHeight = 0;
  late final AboutController _controller;
  final ScrollController _scrollController = ScrollController();
  Offset _cursorPosition = Offset.zero;
  bool _showCursorFollower = false;
  bool _hasStartedImagePreload = false;
  bool _areCriticalImagesLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AboutController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStartedImagePreload) return;
    _hasStartedImagePreload = true;
    _preloadCriticalImages();
  }

  Future<void> _preloadCriticalImages() async {
    // Dismiss the HTML splash immediately — the Flutter in-app loader takes over.
    hideWebLoader();

    try {
      await Future.wait([
        precacheImage(const NetworkImage(_logoImageUrl), context),
        precacheImage(const NetworkImage(_labibPortfolioImageUrl), context),
        precacheImage(const NetworkImage(_labibProfileImageUrl), context),
      ]);
    } catch (_) {
      // Continue so users are not blocked by a failed image preload.
    }

    if (!mounted) return;
    setState(() => _areCriticalImagesLoaded = true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _measureContact(Duration _) {
    final context = _contactKey.currentContext;
    if (context == null) {
      return;
    }
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox) {
      return;
    }
    final height = renderObject.size.height;
    if ((height - _contactHeight).abs() > 1) {
      setState(() => _contactHeight = height);
    }
  }

  void _updateCursorFollower(PointerEvent event) {
    final renderObject = _cursorRegionKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox) {
      return;
    }
    final localPosition = renderObject.globalToLocal(event.position);
    final size = renderObject.size;
    final dx = localPosition.dx.clamp(0.0, size.width);
    final dy = localPosition.dy.clamp(0.0, size.height);
    setState(() {
      _cursorPosition = Offset(dx, dy);
      _showCursorFollower = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_measureContact);
    final controller = _controller;
    final contactHeight = _contactHeight > 0 ? _contactHeight : 800.0;

    return Obx(() {
      final isDark = _controller.themeController.isDark;
      return Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF25232E)
            : AppColors.backgroundLight,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = ResponsiveUtils.isMobile(context);
            final isTablet = ResponsiveUtils.isTablet(context);

            return Stack(
              children: [
                MouseRegion(
                  onExit: (_) => setState(() => _showCursorFollower = false),
                  child: Listener(
                    key: _cursorRegionKey,
                    behavior: HitTestBehavior.translucent,
                    onPointerHover: _updateCursorFollower,
                    onPointerMove: _updateCursorFollower,
                    onPointerDown: _updateCursorFollower,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              // Hero Section
                              Container(
                                key: controller.homeKey,
                                child: _buildHeroSection(
                                  context,
                                  controller,
                                  constraints,
                                ),
                              ),

                              // About Section
                              Container(
                                key: controller.aboutKey,
                                child: const RepaintBoundary(
                                  child: PersonalInfoSection(),
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Work Experience Section
                              Container(
                                key: controller.experienceKey,
                                child: const RepaintBoundary(
                                  child: ExperienceSection(),
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Projects Section
                              Container(
                                key: controller.projectsKey,
                                child: const RepaintBoundary(
                                  child: ProjectsSection(),
                                ),
                              ),

                              // SizedBox(height: isMobile ? 20 : 30),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile
                                      ? 12
                                      : (isTablet ? 30 : 40),
                                  vertical: isMobile
                                      ? 20
                                      : (isTablet ? 30 : 40),
                                ),
                                child: _buildAnimatedSkillsBanner(),
                              ),

                              // Skills Section
                              Container(
                                key: controller.skillsKey,
                                child: const RepaintBoundary(
                                  child: ModernSkillsSection(),
                                ),
                              ),

                              // Contact Me Section (overlap Projects by 40)
                              SizedBox(
                                height: contactHeight - _contactOverlap,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -_contactOverlap,
                                      left: 0,
                                      right: 0,
                                      child: KeyedSubtree(
                                        key: _contactKey,
                                        child: Container(
                                          key: controller.contactKey,
                                          child: const ContactMeSection(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Footer Section
                              const FooterSection(),
                            ],
                          ),
                        ),
                        Positioned(
                          right: isMobile ? 16 : 32,
                          bottom: isMobile ? 24 : 32,
                          child: SafeArea(
                            child: BackToTopFloatingButton(
                              scrollController: _scrollController,
                            ),
                          ),
                        ),
                        if (!isMobile)
                          CursorFollower(
                            position: _cursorPosition,
                            size: _cursorFollowerSize,
                            isVisible: _showCursorFollower,
                          ),
                      ],
                    ),
                  ),
                ),
                if (!_areCriticalImagesLoaded) _buildStartupLoader(isDark),
              ],
            );
          },
        ),
      );
    });
  }

  Widget _buildStartupLoader(bool isDark) {
    return Positioned.fill(
      child: Container(
        color: isDark ? const Color(0xFF0D0D0D) : AppColors.backgroundLight,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(_logoImageUrl, width: 80, height: 80),
              const SizedBox(height: 24),
              const SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.primaryOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSkillsBanner() {
    return Container(
      height: 130,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isMobile || isTablet) {
      return _buildMobileNavbar(context, controller, isDark);
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
            backgroundColor: isDark
                ? const Color(0xFF1A1A1A).withValues(alpha: 0.9)
                : AppColors.gray900,
            borderColor: isDark ? AppColors.borderDark : AppColors.borderLight,
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
                _buildThemeToggle(context, controller, isDark),
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
                fontFamily: 'Montserrat',
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

  Widget _buildThemeToggle(
    BuildContext context,
    AboutController controller,
    bool isDark,
  ) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.gray900.withValues(alpha: 0.5)
              : AppColors.gray900.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 99, 40, 0),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: FaIcon(
            controller.themeController.isDarkMode.value
                ? FontAwesomeIcons.solidSun
                : FontAwesomeIcons.solidMoon,
            color: AppColors.primaryOrange,
            size: 20,
          ),
          onPressed: () => controller.themeController.toggleTheme(),
          tooltip: 'Toggle Theme',
        ),
      ),
    );
  }

  Widget _buildMobileNavbar(
    BuildContext context,
    AboutController controller,
    bool isDark,
  ) {
    return Obx(
      () => AnimatedOpacity(
        opacity: controller.showContent.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: GlassContainer(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: isDark
              ? const Color(0xFF1A1A1A).withValues(alpha: 0.9)
              : AppColors.gray900,
          borderColor: isDark ? AppColors.borderDark : AppColors.borderLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(context, isMobile: true),
              Row(
                children: [
                  // Theme Toggle
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.gray900.withValues(alpha: 0.5)
                          : AppColors.gray900.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(
                      //   color: const Color.fromARGB(255, 99, 40, 0),
                      //   width: 1,
                      // ),
                    ),
                    child: IconButton(
                      icon: FaIcon(
                        controller.themeController.isDarkMode.value
                            ? FontAwesomeIcons.solidSun
                            : FontAwesomeIcons.solidMoon,
                        color: AppColors.primaryOrange,
                        size: 20,
                      ),
                      onPressed: () => controller.themeController.toggleTheme(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Menu Button
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.bars,
                      color: AppColors.textWhite,
                      size: 24,
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
                    'Navigation Menu',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.solidCircleXmark,
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
                        fontFamily: 'Montserrat',
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
                        ? const FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
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
          Image.network(_logoImageUrl, width: 25, height: 25),
          Transform.translate(
            offset: const Offset(0, 0),
            child: Text(
              'ABIB',
              style: GoogleFonts.k2d(
                fontSize: isMobile ? 23 : 23,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryOrange,
                letterSpacing: 2.5,
              ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Stack(
            children: [
              // Hello Badge and Title
              Center(
                child: Stack(
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
                              _buildHelloBadge(context, isDark),
                              SizedBox(height: isMobile ? 24 : 10),
                              isMobile
                                  ? Transform.translate(
                                      offset: const Offset(0, 0),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 20 : 60,
                                        ),
                                        child: _buildMainTitle(context, isDark),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 20 : 60,
                                      ),
                                      child: _buildMainTitle(context, isDark),
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
              ),

              // Profile Image with Orange Background
              // SizedBox(height: isMobile ? 40 : 50),
              Center(
                child: Stack(
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

  Widget _buildHelloBadge(BuildContext context, bool isDark) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.49,
            vertical: 12.745,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.backgroundGlassDark
                : AppColors.backgroundGlass,
            borderRadius: BorderRadius.circular(38.235),
            border: Border.all(
              color: isDark ? AppColors.borderLight : AppColors.borderDark,
              width: 1.275,
            ),
          ),
          child: Text(
            'Hello!',
            style: GoogleFonts.montserrat(
              fontSize: 20, // Figma: 20px
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
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

  Widget _buildMainTitle(BuildContext context, bool isDark) {
    final isTablet = ResponsiveUtils.isTablet(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    // Improved mobile font size for better readability
    final fontSize = isMobile ? 60.0 : (isTablet ? 52.0 : 92.0);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
          letterSpacing: isMobile ? -0.8 : -1.4335,
          height: isMobile ? 1.2 : 1.0,
        ),
        children: [
          TextSpan(text: "It's "),
          TextSpan(
            text: 'Labibur',
            style: TextStyle(
              color: isDark
                  ? const Color.fromARGB(255, 255, 98, 0)
                  : AppColors.primaryOrange,
            ),
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
          colorFilter: _controller.themeController.isDark
              ? const ColorFilter.mode(
                  AppColors.textDarkSecondary,
                  BlendMode.srcIn,
                )
              : const ColorFilter.mode(AppColors.gray700, BlendMode.srcIn),
          width: isDesktop ? 36 : 28,
          height: isDesktop ? 36 : 28,
        ),
        SizedBox(height: isDesktop ? 24 : 16),
        // Quote Text - Figma: 20px
        Text(
          AppStrings.testimonialText,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: isDesktop ? 20 : 16,
            fontWeight: FontWeight.w500,
            color: _controller.themeController.isDark
                ? AppColors.textDarkSecondary
                : AppColors.gray700,
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
            fontFamily: 'Montserrat',
            fontSize: isDesktop ? 47 : 36,
            fontWeight: FontWeight.w700,
            color: _controller.themeController.isDark
                ? AppColors.textDarkPrimary
                : AppColors.textPrimary,
            letterSpacing: -0.705,
          ),
        ),
        const SizedBox(height: 5),
        // Label
        Text(
          AppStrings.experienceLabel,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: isDesktop ? 20 : 16,
            fontWeight: FontWeight.w400,
            color: _controller.themeController.isDark
                ? AppColors.textDarkPrimary
                : AppColors.textPrimary,
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
        ? screenWidth * 1.4
        : (isTablet ? 870.0 : 1236.0);
    final ellipseWidth = isMobile
        ? screenWidth * 0.5
        : (isTablet ? 500.0 : 811.779);
    final ellipseHeight = isMobile
        ? screenWidth * 0.5
        : (isTablet ? 250.0 : 405.889);

    // Responsive bottom positioning for profile image
    final profileBottom = isMobile ? -70.0 : (isTablet ? -120.0 : -350.0);

    return SizedBox(
      width: profileWidth,
      height: isMobile
          ? profileHeight + 80
          : (isTablet)
          ? profileHeight - 150
          : profileHeight - 400, // Old 180
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
            bottom: profileBottom,
            child: Transform.translate(
              offset: const Offset(0, 60),
              child: SizedBox(
                width: isMobile ? profileWidth * 1.3 : profileWidth,
                height: isMobile ? profileHeight * 1.2 : profileHeight,
                child: Image.network(
                  _labibPortfolioImageUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.gray300,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.solidUser,
                          size: isMobile ? 100 : (isTablet ? 150 : 200),
                          color: AppColors.gray700,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // CTA Buttons at bottom
          Positioned(
            bottom: isMobile ? 20 : (isTablet ? 30 : 40),
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
                isMobile ? AppStrings.resumeMobileBtn : AppStrings.resumeBtn,
                style: TextStyle(
                  fontFamily: 'Montserrat',
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
        onTap: () => controller.onNavItemTap(3), // Navigate to Contact section
        // onTap: controller.onHireMeTap,
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
              fontFamily: 'Montserrat',
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
