import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Animate in after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServicesController());
    final isMobile = ResponsiveUtils.isMobile(context);

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.1),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.gray900,
            ),
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.myServicesBackgroundContainerBg,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: AppColors.gray900);
                    },
                  ),
                ),

                // Decorative 3D elements
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: isMobile ? 400 : 960,
                    child: Stack(
                      children: [
                        // Right blob
                        if (!isMobile)
                          Positioned(
                            right: -150,
                            // top: 146,
                            bottom: -100,
                            child: SizedBox(
                              width: 700,
                              height: 700,
                              child: Image.asset(
                                AppAssets.myServicesRightBlob,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                        // Top center blob (smaller, blurred)
                        if (!isMobile)
                          Positioned(
                            left: MediaQuery.of(context).size.width / 2 - 125,
                            top: 21,
                            child: SizedBox(
                              width: 180,
                              height: 180,
                              child: Image.asset(
                                AppAssets.myServicesTopCenterBlob,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                        // Left blob
                        if (!isMobile)
                          Positioned(
                            top: 30,
                            left: -100,
                            child: SizedBox(
                              width: 400,
                              height: 400,
                              child: Image.asset(
                                AppAssets.myServicesLeftBlob,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Main Content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 71,
                    vertical: isMobile ? 60 : 116,
                  ),
                  child: Column(
                    children: [
                      // Header
                      _buildHeader(context),
                      SizedBox(height: isMobile ? 40 : 96),

                      // Service Cards
                      _buildServiceCards(context, controller),
                      SizedBox(height: isMobile ? 30 : 39),

                      // Page Indicator
                      Obx(
                        () => PageIndicator(
                          totalPages: controller.services.length,
                          currentPage: controller.currentPage.value,
                          onTap: controller.changePage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: 20),
          _buildDescription(context),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(child: _buildTitle(context)),
        const SizedBox(width: 20),
        Flexible(
          child: SizedBox(
            width: isTablet ? 400 : 576,
            child: _buildDescription(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: isMobile ? 32 : (isTablet ? 40 : 48), // Figma: 48px desktop
          fontWeight: FontWeight.w600,
          letterSpacing: -0.72,
          height: 1.0,
        ),
        children: const [
          TextSpan(
            text: 'My ',
            style: TextStyle(color: Color(0xFFFCFCFD)),
          ),
          TextSpan(
            text: 'Services',
            style: TextStyle(color: AppColors.primaryOrange),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Text(
      'I specialize in building cross-platform mobile applications with Flutter and native Android apps with Kotlin.',
      style: TextStyle(
        fontFamily: 'Urbanist',
        fontSize: isMobile ? 14 : 20, // Figma: 20px desktop
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: -0.3,
        height: 1.5,
      ),
    );
  }

  Widget _buildServiceCards(
    BuildContext context,
    ServicesController controller,
  ) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    if (isMobile) {
      // Show one card at a time on mobile with PageView
      return Container(
        height: 400,
        child: PageView.builder(
          onPageChanged: controller.changePage,
          itemCount: controller.services.length,
          itemBuilder: (context, index) {
            return Center(
              child: ServiceCard(
                title: controller.services[index].title,
                imagePath: controller.services[index].imagePath,
              ),
            );
          },
        ),
      );
    }

    // Auto-scrolling horizontal carousel for tablet and desktop
    return Obx(() {
      final currentPage =
          controller.currentPage.value; // Access observable here
      return SizedBox(
        height: isTablet ? 520 : 540,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Current and next cards with animated transition
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1200),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                // Slide out animation (current cards move left)
                final offsetAnimation =
                    Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-1.0, 0),
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: const Interval(
                          0.0,
                          0.5,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                    );

                // Slide in animation (new cards come from right)
                final reverseAnimation =
                    Tween<Offset>(
                      begin: const Offset(1.0, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: const Interval(
                          0.5,
                          1.0,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    );

                return SlideTransition(
                  position: animation.status == AnimationStatus.reverse
                      ? offsetAnimation
                      : reverseAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Container(
                key: ValueKey<int>(currentPage),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildVisibleCardsWithBlur(
                    context,
                    controller,
                    isTablet,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildVisibleCardsWithBlur(
    BuildContext context,
    ServicesController controller,
    bool isTablet,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardsToShow = screenWidth > 1300 ? 3 : 2;
    final currentIndex = controller.currentPage.value;
    final List<Widget> cards = [];

    for (int i = 0; i < cardsToShow; i++) {
      final index = (currentIndex + i) % controller.services.length;
      final isCenter = i == 0; // First card is the center/main card

      cards.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: cardsToShow == 3 ? 8 : 12.5,
          ),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 400 + (i * 100)),
            curve: Curves.easeOutCubic,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: isCenter ? 1.0 : 0.95 + (value * 0.05),
                child: Opacity(
                  opacity: isCenter ? 1.0 : 0.6 + (value * 0.4),
                  child: child,
                ),
              );
            },
            child: ServiceCard(
              title: controller.services[index].title,
              imagePath: controller.services[index].imagePath,
            ),
          ),
        ),
      );
    }

    return cards;
  }
}
