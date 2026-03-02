import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late ProjectsController controller;
  final PageController _screenshotController = PageController();
  Timer? _autoScrollTimer;
  bool _isVisible = false;
  int _currentScreenshotIndex = 0;
  int? _hoveredLinkIndex;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProjectsController());

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });

    _startAutoScroll();

    // Listen for project changes and reset screenshot slider
    ever(controller.selectedProjectIndex, (_) {
      if (_screenshotController.hasClients) {
        _screenshotController.jumpToPage(0);
        _startAutoScroll(); // Restart auto-scroll
      }
      if (mounted) {
        setState(() => _currentScreenshotIndex = 0);
      }
    });
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_screenshotController.hasClients && mounted) {
        final selectedProject =
            controller.projects[controller.selectedProjectIndex.value];
        final maxPages = selectedProject.screenshots.length;
        final nextPage = (_screenshotController.page ?? 0).toInt() + 1;

        if (nextPage < maxPages) {
          _screenshotController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        } else {
          _screenshotController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _screenshotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1.0 : 0.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppColors.cardDark,
                    AppColors.surfaceDarkElevated,
                    AppColors.surfaceDark,
                  ]
                : [
                    Color(0xFFFFF8F0),
                    Color(0xFFFFF3E8),
                    AppColors.primaryOrange.withValues(alpha: 0.08),
                  ],
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            // Background decorative shapes
            Positioned(
              top: 50,
              right: -100,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.15),
                      AppColors.primaryOrange.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -150,
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.12),
                      AppColors.primaryOrange.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 100,
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryOrange.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // New decorative shapes
            Positioned(
              top: 400,
              right: 50,
              child: Transform.rotate(
                angle: -0.3,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.primaryOrange.withValues(alpha: 0.15),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              right: 200,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.2),
                    width: 3,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              right: 300,
              child: Transform.rotate(
                angle: 0.8,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.2),
                      AppColors.primaryOrange.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Additional decorative shapes
            Positioned(
              top: 300,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.1),
                      AppColors.primaryOrange.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 300,
              right: -80,
              child: Transform.rotate(
                angle: 0.6,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.primaryOrange.withValues(alpha: 0.12),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: 150,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryOrange.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              bottom: 400,
              left: 300,
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryOrange.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 150,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.25),
                    width: 2,
                  ),
                ),
              ),
            ),
            // More decorative shapes for visual appeal
            Positioned(
              top: 250,
              right: 400,
              child: Transform.rotate(
                angle: 0.4,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.primaryOrange.withValues(alpha: 0.18),
                      width: 2.5,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 50,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.15),
                      AppColors.primaryOrange.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 80,
              child: Transform.rotate(
                angle: -0.7,
                child: Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.primaryOrange.withValues(alpha: 0.09),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 250,
              left: 400,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.22),
                    width: 2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 450,
              right: 250,
              child: Transform.rotate(
                angle: 0.9,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryOrange.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Main content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : (isTablet ? 60 : 80),
                vertical: isMobile ? 60 : (isTablet ? 80 : 100),
              ),
              child: Column(
                children: [
                  _buildHeader(isMobile, isTablet),
                  SizedBox(height: isMobile ? 40 : 60),
                  isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(isTablet),
                  SizedBox(height: isMobile ? 40 : 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isTablet) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: RichText(
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        text: TextSpan(
          style: TextStyle(
            fontSize: isMobile ? 36 : (isTablet ? 48 : 56),
            fontWeight: FontWeight.w700,
            letterSpacing: -0.72,
            height: 1.1,
          ),
          children: [
            TextSpan(
              text: 'My ',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            TextSpan(
              text: 'Projects',
              style: TextStyle(color: AppColors.primaryOrange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildPhoneMockup(true, false),
        const SizedBox(height: 16),
        _buildScreenshotIndicators(true, false),
        const SizedBox(height: 40),
        _buildProjectsList(true, false, isLeft: true),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isTablet) {
    if (isTablet) {
      // Tablet: Keep original 2-column layout
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildProjectsList(false, isTablet, isLeft: true),
          ),
          SizedBox(width: 40),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildPhoneMockup(false, isTablet),
                const SizedBox(height: 20),
                _buildScreenshotIndicators(false, isTablet),
              ],
            ),
          ),
        ],
      );
    }

    // Desktop: 3-column layout
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left projects
        Expanded(
          flex: 2,
          child: _buildProjectsList(false, isTablet, isLeft: true),
        ),
        SizedBox(width: 60),
        // Center phone mockup
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildPhoneMockup(false, isTablet),
              const SizedBox(height: 20),
              _buildScreenshotIndicators(false, isTablet),
            ],
          ),
        ),
        SizedBox(width: 60),
        // Right projects
        Expanded(
          flex: 2,
          child: _buildProjectsList(false, isTablet, isLeft: false),
        ),
      ],
    );
  }

  Widget _buildProjectsList(
    bool isMobile,
    bool isTablet, {
    bool isLeft = true,
  }) {
    final startIndex = isLeft ? 0 : 4;
    final endIndex = isLeft
        ? (controller.projects.length >= 4 ? 4 : controller.projects.length)
        : (controller.projects.length >= 8 ? 8 : controller.projects.length);

    // Handle edge cases where there might not be enough projects
    if (startIndex >= controller.projects.length) {
      return const SizedBox.shrink();
    }

    final projectsToShow = controller.projects.sublist(
      startIndex,
      endIndex > controller.projects.length
          ? controller.projects.length
          : endIndex,
    );

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(isLeft ? -50 * (1 - value) : 50 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...projectsToShow.asMap().entries.map((entry) {
            final projectIndex = startIndex + entry.key;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildProjectItem(
                entry.value,
                projectIndex,
                isMobile,
                isTablet,
                isLeft: isLeft,
              ),
            );
          }),
          if (isMobile) ...[
            const SizedBox(height: 20),
            _buildViewAllButton(isMobile),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectItem(
    ProjectModel project,
    int index,
    bool isMobile,
    bool isTablet, {
    bool isLeft = true,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Obx(() {
        final isSelected = controller.selectedProjectIndex.value == index;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => controller.selectProject(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 20 : 24),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withValues(alpha: 0.0),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryOrange
                      : Theme.of(context).brightness == Brightness.dark
                      ? AppColors.borderDarkMode
                      : AppColors.gray200,
                  width: isSelected ? 2 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.primaryOrange.withValues(alpha: 0.09)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: isSelected ? 30 : 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (project.isPublished) ...[
                    _buildPublishedBadge(isMobile),
                    const SizedBox(height: 10),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildProjectTitle(
                          project.title,
                          isMobile,
                          isTablet,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildProjectLink(project, index, isMobile),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTechStackHorizontal(project.technologies, isMobile),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProjectTitle(String title, bool isMobile, bool isTablet) {
    List<InlineSpan> titleSpans = [];
    RegExp regExp = RegExp(r'\*([^*]+)\*');
    int lastIndex = 0;

    for (Match match in regExp.allMatches(title)) {
      if (match.start > lastIndex) {
        titleSpans.add(
          TextSpan(
            text: title.substring(lastIndex, match.start),
            style: TextStyle(
              fontSize: isMobile ? 18 : (isTablet ? 20 : 22),
              fontWeight: FontWeight.w400,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.3,
            ),
          ),
        );
      }

      titleSpans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontSize: isMobile ? 18 : (isTablet ? 20 : 22),
            fontWeight: FontWeight.w700,
            color: AppColors.primaryOrange,
            height: 1.3,
          ),
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < title.length) {
      titleSpans.add(
        TextSpan(
          text: title.substring(lastIndex),
          style: TextStyle(
            fontSize: isMobile ? 18 : (isTablet ? 20 : 22),
            fontWeight: FontWeight.w400,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
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

  Widget _buildTechStackHorizontal(List<String> technologies, bool isMobile) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: technologies.take(4).map((tech) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primaryOrange.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            tech,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryOrange,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjectLink(ProjectModel project, int index, bool isMobile) {
    final linkUrl = project.link;
    final linkLabel = project.linkLabel;
    if (linkUrl == null ||
        linkUrl.isEmpty ||
        linkLabel == null ||
        linkLabel.isEmpty) {
      return const SizedBox.shrink();
    }

    final isHovered = _hoveredLinkIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!isMobile) {
          setState(() => _hoveredLinkIndex = index);
        }
      },
      onExit: (_) {
        if (!isMobile) {
          setState(() => _hoveredLinkIndex = null);
        }
      },
      child: GestureDetector(
        onTap: () => _openProjectLink(linkUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 14 : 16,
            vertical: isMobile ? 8 : 10,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryOrange.withValues(alpha: 0.95),
                AppColors.primaryOrange.withValues(alpha: 0.75),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withValues(
                  alpha: isHovered ? 0.35 : 0.2,
                ),
                blurRadius: isHovered ? 18 : 12,
                offset: Offset(0, isHovered ? 8 : 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                _getProjectLinkIcon(linkLabel),
                size: isMobile ? 14 : 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPublishedBadge(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 12,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryOrange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryOrange.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        'Published App',
        style: TextStyle(
          fontSize: isMobile ? 11 : 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryOrange,
        ),
      ),
    );
  }

  IconData _getProjectLinkIcon(String label) {
    switch (label.toLowerCase()) {
      case 'github':
        return FontAwesomeIcons.github;
      case 'play store':
      case 'playstore':
      case 'google play':
        return FontAwesomeIcons.googlePlay;
      case 'app store':
      case 'appstore':
      case 'ios app store':
        return FontAwesomeIcons.appStoreIos;
      default:
        return FontAwesomeIcons.link;
    }
  }

  Future<void> _openProjectLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildViewAllButton(bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'View All Projects',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneMockup(bool isMobile, bool isTablet) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Center(
        child: Container(
          width: isMobile ? 300 : (isTablet ? 320 : 325),
          height: isMobile ? 600 : (isTablet ? 640 : 720),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withValues(alpha: 0.3),
                blurRadius: 60,
                offset: const Offset(0, 20),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Screenshot slider (behind phone)
              Positioned.fill(
                child: Transform.scale(
                  scale: 0.98,
                  child: Container(
                    child: _buildScreenshotSlider(isMobile, isTablet),
                  ),
                ),
              ),
              // Phone frame
              _buildPhoneFrame(isMobile, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotSlider(bool isMobile, bool isTablet) {
    return Obx(() {
      final selectedProject =
          controller.projects[controller.selectedProjectIndex.value];
      final screenshots = selectedProject.screenshots;

      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // Stop auto-scroll on manual interaction
            _autoScrollTimer?.cancel();

            // Determine direction and navigate
            if (details.primaryVelocity! < 0) {
              // Swipe left - next page
              final currentPage = (_screenshotController.page ?? 0).toInt();
              if (currentPage < screenshots.length - 1) {
                _screenshotController.animateToPage(
                  currentPage + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            } else if (details.primaryVelocity! > 0) {
              // Swipe right - previous page
              final currentPage = (_screenshotController.page ?? 0).toInt();
              if (currentPage > 0) {
                _screenshotController.animateToPage(
                  currentPage - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }

            // Resume auto-scroll after interaction
            Future.delayed(const Duration(seconds: 2), () {
              _startAutoScroll();
            });
          },
          child: PageView.builder(
            controller: _screenshotController,
            itemCount: screenshots.length,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) {
              if (mounted) {
                setState(() => _currentScreenshotIndex = index);
              }
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(color: AppColors.gray100),
                child: Image.asset(
                  screenshots[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryOrange.withValues(alpha: 0.8),
                            AppColors.gray800.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.mobileScreen,
                              size: isMobile ? 60 : 80,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Screenshot ${index + 1}',
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildScreenshotIndicators(bool isMobile, bool isTablet) {
    return Obx(() {
      final selectedProject =
          controller.projects[controller.selectedProjectIndex.value];
      final screenshots = selectedProject.screenshots;
      if (screenshots.length <= 1) {
        return const SizedBox.shrink();
      }

      return Wrap(
        spacing: 8,
        children: List.generate(screenshots.length, (index) {
          final isActive = _currentScreenshotIndex == index;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                _screenshotController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: isActive ? 30 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryOrange
                      : AppColors.primaryOrange.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primaryOrange.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _buildPhoneFrame(bool isMobile, bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black, width: isMobile ? 8 : 8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Column(
          children: [Expanded(child: Container(color: Colors.transparent))],
        ),
      ),
    );
  }
}

// Custom painter for arrow indicator
class ArrowPainter extends CustomPainter {
  final Color color;
  final bool pointingRight;

  ArrowPainter({required this.color, required this.pointingRight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (pointingRight) {
      // Arrow pointing right
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width * 0.7, size.height / 2);
      path.moveTo(size.width * 0.5, size.height * 0.3);
      path.lineTo(size.width * 0.7, size.height / 2);
      path.lineTo(size.width * 0.5, size.height * 0.7);
    } else {
      // Arrow pointing left
      path.moveTo(size.width, size.height / 2);
      path.lineTo(size.width * 0.3, size.height / 2);
      path.moveTo(size.width * 0.5, size.height * 0.3);
      path.lineTo(size.width * 0.3, size.height / 2);
      path.lineTo(size.width * 0.5, size.height * 0.7);
    }

    canvas.drawPath(path, paint);

    // Add decorative dots
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    if (pointingRight) {
      canvas.drawCircle(
        Offset(size.width * 0.85, size.height / 2),
        2.5,
        dotPaint,
      );
      canvas.drawCircle(
        Offset(size.width * 0.95, size.height / 2),
        2,
        dotPaint,
      );
    } else {
      canvas.drawCircle(
        Offset(size.width * 0.15, size.height / 2),
        2.5,
        dotPaint,
      );
      canvas.drawCircle(
        Offset(size.width * 0.05, size.height / 2),
        2,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.pointingRight != pointingRight;
  }
}
