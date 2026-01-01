import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/animated_skills_marquee.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late ProjectsController controller;
  late PageController pageController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProjectsController());
    pageController = PageController(viewportFraction: 0.9);

    // Sync PageController with controller.currentPage
    ever(controller.currentPage, (page) {
      if (pageController.hasClients && pageController.page?.round() != page) {
        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    // Trigger entrance animation
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    // Update max pages based on screen size
    final itemsPerPage = isMobile ? 1 : (isTablet ? 2 : 3);
    final maxPages = (controller.projects.length / itemsPerPage).ceil();
    controller.setMaxPages(maxPages);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 800),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.1),
        curve: Curves.easeOutCubic,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : (isTablet ? 60 : 80),
            vertical: isMobile ? 60 : (isTablet ? 80 : 100),
          ),
          color: Colors.white,
          child: Column(
            children: [
              _buildHeader(isMobile, isTablet),
              SizedBox(height: isMobile ? 40 : 60),
              _buildProjectsGrid(isMobile, isTablet),
              SizedBox(height: isMobile ? 30 : 50),
              _buildPagination(isMobile),
              SizedBox(height: isMobile ? 60 : 80),
              _buildAnimatedSkillsBanner(),
            ],
          ),
        ),
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
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

  Widget _buildHeader(bool isMobile, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(-30 * (1 - value), 0),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: isMobile ? 36 : (isTablet ? 42 : 48),
                fontWeight: FontWeight.w700,
                letterSpacing: -0.72,
                height: 1.1,
              ),
              children: [
                TextSpan(
                  text: 'My ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Projects',
                  style: TextStyle(color: AppColors.primaryOrange),
                ),
              ],
            ),
          ),
        ),
        if (!isMobile)
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(30 * (1 - value), 0),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: _buildSeeAllButton(),
          ),
      ],
    );
  }

  Widget _buildSeeAllButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigate to all projects page
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(bool isMobile, bool isTablet) {
    // Calculate how many items to show
    final itemsPerPage = isMobile ? 1 : (isTablet ? 2 : 3);

    return Obx(() {
      final currentIndex = controller.currentPage.value;
      // Calculate start and end indices for visible items
      final startIndex = currentIndex * itemsPerPage;
      final endIndex = (startIndex + itemsPerPage).clamp(
        0,
        controller.projects.length,
      );
      final visibleProjects = controller.projects.sublist(startIndex, endIndex);

      return SizedBox(
        height: isMobile ? 620 : (isTablet ? 640 : 660),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: visibleProjects.asMap().entries.map((entry) {
            final localIndex = entry.key;
            final project = entry.value;
            final globalIndex = startIndex + localIndex;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: localIndex == 0
                      ? 0
                      : (isMobile ? 8 : (isTablet ? 12 : 16)),
                  right: localIndex == visibleProjects.length - 1
                      ? 0
                      : (isMobile ? 8 : (isTablet ? 12 : 16)),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        final offsetAnimation =
                            Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOutCubic,
                              ),
                            );

                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                  child: _buildProjectCard(
                    project,
                    globalIndex,
                    isMobile,
                    isTablet,
                    key: ValueKey('project_$globalIndex'),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildProjectCard(
    ProjectModel project,
    int index,
    bool isMobile,
    bool isTablet, {
    Key? key,
  }) {
    return MouseRegion(
      key: key,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigate to project detail
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectImage(project, isMobile, isTablet),
            const SizedBox(height: 10),
            _buildPlatformBadges(project.platforms, isMobile),
            const SizedBox(height: 10),
            _buildTechStack(project.technologies, isMobile),
            const SizedBox(height: 20),
            _buildProjectTitle(project.title, isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage(
    ProjectModel project,
    bool isMobile,
    bool isTablet,
  ) {
    return SizedBox(
      height: isMobile ? 350 : (isTablet ? 380 : 430),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          AppAssets.project1,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryOrange.withOpacity(0.1),
                    AppColors.gray700.withOpacity(0.1),
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(
                  AppAssets.project1,
                  width: isMobile ? 60 : 80,
                  height: isMobile ? 60 : 80,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlatformBadges(List<String> platforms, bool isMobile) {
    return SizedBox(
      height: isMobile ? 48 : 56,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: platforms.map((platform) {
            return Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 12 : 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    platform,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTechStack(List<String> technologies, bool isMobile) {
    return SizedBox(
      height: isMobile ? 36 : 42,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: technologies.map((tech) {
            return Padding(
              padding: const EdgeInsets.only(right: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    tech,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildProjectTitle(String title, bool isMobile, bool isTablet) {
    // Parse title for styled project name between *...*
    List<InlineSpan> titleSpans = [];

    RegExp regExp = RegExp(r'\*([^*]+)\*');
    int lastIndex = 0;

    for (Match match in regExp.allMatches(title)) {
      // Add text before the match
      if (match.start > lastIndex) {
        titleSpans.add(
          TextSpan(
            text: title.substring(lastIndex, match.start),
            style: TextStyle(
              fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
              fontWeight: FontWeight.w400,
              color: AppColors.gray700,
              height: 1.3,
            ),
          ),
        );
      }

      // Add the styled project name
      titleSpans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
            fontWeight: FontWeight.w700,
            color: AppColors.primaryOrange,
            height: 1.3,
          ),
        ),
      );

      lastIndex = match.end;
    }

    // Add remaining text
    if (lastIndex < title.length) {
      titleSpans.add(
        TextSpan(
          text: title.substring(lastIndex),
          style: TextStyle(
            fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
            fontWeight: FontWeight.w400,
            color: AppColors.gray700,
            height: 1.3,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: titleSpans),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPagination(bool isMobile) {
    if (!isMobile) {
      return _buildDesktopPagination();
    }

    return Obx(() {
      final isMobile = ResponsiveUtils.isMobile(context);
      final isTablet = ResponsiveUtils.isTablet(context);
      final itemsPerPage = isMobile ? 1 : (isTablet ? 2 : 3);
      final maxPageIndex =
          (controller.projects.length / itemsPerPage).ceil() - 1;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavigationButton(
            icon: Iconsax.arrow_left_2,
            onTap: controller.previousProject,
            enabled: controller.currentPage.value > 0,
          ),
          const SizedBox(width: 20),
          _buildDots(),
          const SizedBox(width: 20),
          _buildNavigationButton(
            icon: Iconsax.arrow_right_3,
            onTap: controller.nextProject,
            enabled: controller.currentPage.value < maxPageIndex,
          ),
        ],
      );
    });
  }

  Widget _buildDesktopPagination() {
    return Obx(() => _buildDots());
  }

  Widget _buildDots() {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final itemsPerPage = isMobile ? 1 : (isTablet ? 2 : 3);
    final totalPages = (controller.projects.length / itemsPerPage).ceil();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPages, (index) {
        final isActive = controller.currentPage.value == index;
        return GestureDetector(
          onTap: () => controller.changePage(index),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5.66),
              width: isActive ? 60.32 : 15.08,
              height: 15.08,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryOrange : AppColors.gray200,
                borderRadius: BorderRadius.circular(20.74),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: enabled ? AppColors.primaryOrange : AppColors.gray200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: enabled ? Colors.white : AppColors.gray400,
            size: 24,
          ),
        ),
      ),
    );
  }
}
