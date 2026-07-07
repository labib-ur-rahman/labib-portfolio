import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';

class ModernSkillsSection extends StatefulWidget {
  const ModernSkillsSection({super.key});

  @override
  State<ModernSkillsSection> createState() => _ModernSkillsSectionState();
}

class _ModernSkillsSectionState extends State<ModernSkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _hoveredIndex = RxnInt();
  final _showContent = false.obs;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 100), () {
      _showContent.value = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _skillCategories = [
    {
      'title': 'Mobile Application Development',
      'icon': FontAwesomeIcons.mobileScreen,
      'color': const Color(0xFF6366F1),
      'skills': [
        'Flutter & Dart (Cross-platform)',
        'Native Android (Kotlin, Java)',
        'Jetpack Compose & XML-based UI',
        'Scalable App Architecture',
      ],
    },
    {
      'title': 'State Management & Architecture',
      'icon': FontAwesomeIcons.layerGroup,
      'color': const Color(0xFF8B5CF6),
      'skills': [
        'GetX (State, DI, Routing)',
        'MVVM / MVC Design Patterns',
        'Clean Architecture Principles',
      ],
    },
    {
      'title': 'UI / UX Engineering',
      'icon': FontAwesomeIcons.paintbrush,
      'color': const Color(0xFFEC4899),
      'skills': [
        'Material Design Guidelines',
        'Responsive & Adaptive Layouts',
        'Accessibility-focused Design',
        'UI Prototyping (Figma, Adobe XD)',
      ],
    },
    {
      'title': 'Backend Integration & APIs',
      'icon': FontAwesomeIcons.code,
      'color': const Color(0xFF10B981),
      'skills': [
        'RESTful API Integration',
        'Server-Sent Events (SSE)',
        'Firebase & JWT Authentication',
        'Push Notifications (FCM)',
      ],
    },
    {
      'title': 'Cloud & Database Services',
      'icon': FontAwesomeIcons.cloud,
      'color': const Color(0xFF3B82F6),
      'skills': [
        'Firebase (Firestore, Realtime DB)',
        'Room & Hive Database',
        'Secure & Encrypted Storage',
        'Google Cloud Services',
      ],
    },
    {
      'title': 'Third-Party Integration',
      'icon': FontAwesomeIcons.cube,
      'color': const Color(0xFFF59E0B),
      'skills': [
        'Google Maps SDK',
        'Stripe Payment Integration',
        'Social Media SDKs',
      ],
    },
    {
      'title': 'Development Tools & Version Control',
      'icon': FontAwesomeIcons.gear,
      'color': const Color(0xFF14B8A6),
      'skills': [
        'Git & GitHub',
        'Android Studio & VS Code',
        'Postman API Testing',
        'Code Review & Branching',
      ],
    },
    {
      'title': 'App Deployment & Distribution',
      'icon': FontAwesomeIcons.cloudArrowUp,
      'color': AppColors.primaryOrange,
      'skills': [
        'Google Play Store Publishing',
        'Apple App Store Submission',
        'CI/CD Pipeline Setup',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Obx(
      () => AnimatedOpacity(
        opacity: _showContent.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: Builder(
          builder: (context) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          AppColors.surfaceDarkElevated,
                          AppColors.cardDark,
                          AppColors.surfaceDark,
                          AppColors.cardDark,
                        ]
                      : [
                          const Color.fromARGB(255, 255, 237, 222),
                          const Color(0xFFF5F5F7),
                          Colors.white,
                          const Color(0xFFF8F9FA),
                        ],
                  stops: const [0.0, 0.4, 0.6, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Animated Background Gradient Orbs
                  _buildAnimatedBackground(),

                  // Main Content
                  Padding(
                    padding: EdgeInsets.only(
                      left: isMobile ? 20 : (isTablet ? 40 : 80),
                      right: isMobile ? 20 : (isTablet ? 40 : 80),
                      top: isMobile ? 50 : 80,
                      bottom: isMobile ? 50 : 150,
                    ),
                    child: Column(
                      children: [
                        _buildHeader(isMobile, isTablet),
                        SizedBox(height: isMobile ? 40 : 60),
                        _buildSkillsGrid(isMobile, isTablet),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                // Floating orb 1
                Positioned(
                  top: 80 + (40 * _animationController.value),
                  left: -50 + (25 * _animationController.value),
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF6366F1).withValues(alpha: 0.15),
                          const Color(0xFF6366F1).withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                // Floating orb 2
                Positioned(
                  bottom: 100 - (70 * _animationController.value),
                  right: -80 + (30 * _animationController.value),
                  child: Container(
                    width: 450,
                    height: 450,
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
                // Floating orb 3
                Positioned(
                  top: 200 - (50 * _animationController.value),
                  right: 150 + (15 * _animationController.value),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFEC4899).withValues(alpha: 0.08),
                          const Color(0xFFEC4899).withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                // Floating orb 4
                Positioned(
                  bottom: 250 + (35 * _animationController.value),
                  left: 200 - (20 * _animationController.value),
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF10B981).withValues(alpha: 0.09),
                          const Color(0xFF10B981).withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isTablet) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.primaryOrange.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.terminal,
                  color: AppColors.primaryOrange,
                  size: isMobile ? 16 : 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Excellence & Expertise',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryOrange,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Technical ',
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 42 : 56),
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.2,
                  ),
                ),
                TextSpan(
                  text: 'Skills',
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 42 : 56),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryOrange,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A comprehensive toolkit for building exceptional digital experiences',
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textDarkSecondary
                  : Colors.grey[600],
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(bool isMobile, bool isTablet) {
    final crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    const crossAxisSpacing = 20.0;
    const mainAxisSpacing = 20.0;

    final rows = <Widget>[];
    for (
      var start = 0;
      start < _skillCategories.length;
      start += crossAxisCount
    ) {
      final rowItems = _skillCategories
          .skip(start)
          .take(crossAxisCount)
          .toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < crossAxisCount; i++) ...[
                Expanded(
                  child: i < rowItems.length
                      ? _buildSkillCard(rowItems[i], start + i, isMobile)
                      : const SizedBox.shrink(),
                ),
                if (i != crossAxisCount - 1)
                  const SizedBox(width: crossAxisSpacing),
              ],
            ],
          ),
        ),
      );
      if (start + crossAxisCount < _skillCategories.length) {
        rows.add(const SizedBox(height: mainAxisSpacing));
      }
    }

    return Column(children: rows);
  }

  Widget _buildSkillCard(
    Map<String, dynamic> category,
    int index,
    bool isMobile,
  ) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Obx(() {
        final isHovered = _hoveredIndex.value == index;

        return MouseRegion(
          onEnter: (_) => _hoveredIndex.value = index,
          onExit: (_) => _hoveredIndex.value = null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.cardDarkElevated
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isHovered
                    ? category['color'].withValues(alpha: 0.5)
                    : Theme.of(context).brightness == Brightness.dark
                    ? AppColors.borderDarkMode
                    : AppColors.gray200,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? category['color'].withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: isHovered ? 32 : 16,
                  offset: Offset(0, isHovered ? 12 : 6),
                  spreadRadius: isHovered ? 2 : 0,
                ),
              ],
            ),
            transform: Matrix4.identity()
              ..translate(0.0, isHovered ? -8.0 : 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Animated gradient overlay
                  if (isHovered)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              category['color'].withValues(alpha: 0.05),
                              category['color'].withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 20 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Icon with animated background
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isMobile ? 52 : 56,
                          height: isMobile ? 52 : 56,
                          decoration: BoxDecoration(
                            color: category['color'].withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isHovered
                                  ? category['color'].withValues(alpha: 0.5)
                                  : category['color'].withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: FaIcon(
                              category['icon'],
                              color: category['color'],
                              size: isMobile ? 26 : 28,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Title
                        Text(
                          category['title'],
                          style: TextStyle(
                            fontSize: isMobile ? 17 : 18,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),

                        // Skills list
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (category['skills'] as List<String>).map((
                            skill,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: category['color'],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      skill,
                                      style: TextStyle(
                                        fontSize: isMobile ? 13 : 14,
                                        color:
                                            Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppColors.textDarkSecondary
                                            : Colors.grey[600],
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
