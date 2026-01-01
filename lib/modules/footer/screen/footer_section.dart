import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          _buildMainFooter(isMobile, isTablet),
          _buildBottomBar(isMobile),
        ],
      ),
    );
  }

  Widget _buildMainFooter(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 40 : 60,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gray900, Colors.black],
        ),
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(isTablet),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandSection(true),
        const SizedBox(height: 40),
        _buildQuickLinks(true),
        const SizedBox(height: 32),
        _buildServices(true),
        const SizedBox(height: 32),
        _buildContactInfo(true),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildBrandSection(false)),
        if (!isTablet) const SizedBox(width: 60),
        Expanded(flex: 1, child: _buildQuickLinks(false)),
        const SizedBox(width: 40),
        Expanded(flex: 1, child: _buildServices(false)),
        const SizedBox(width: 40),
        Expanded(flex: 1, child: _buildContactInfo(false)),
      ],
    );
  }

  Widget _buildBrandSection(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Labib',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'Dev',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Crafting digital experiences\nwith passion and precision.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.gray400,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          _buildSocialLinks(),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    final socialLinks = [
      {'icon': Iconsax.global, 'label': 'Website', 'delay': 0},
      {'icon': Iconsax.instagram, 'label': 'Instagram', 'delay': 100},
      {'icon': Iconsax.send_2, 'label': 'Telegram', 'delay': 200},
      {'icon': Iconsax.link, 'label': 'LinkedIn', 'delay': 300},
    ];

    return Row(
      children: socialLinks.map((link) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 800 + (link['delay'] as int)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // Handle social link tap
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.gray700, width: 1.5),
                  ),
                  child: Icon(
                    link['icon'] as IconData,
                    color: AppColors.gray400,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickLinks(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Links',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ..._buildFooterLinks([
            'About',
            'Experience',
            'Skills',
            'Projects',
            'Services',
            'Blogs',
          ]),
        ],
      ),
    );
  }

  Widget _buildServices(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ..._buildFooterLinks([
            'UI/UX Design',
            'Mobile Development',
            'Web Development',
            'Consulting',
            'Maintenance',
          ]),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1400),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactItem(Iconsax.call, '+880 1234567890'),
          const SizedBox(height: 12),
          _buildContactItem(Iconsax.sms, 'contact@portfolio.com'),
          const SizedBox(height: 12),
          _buildContactItem(Iconsax.location, 'Dhaka, Bangladesh'),
        ],
      ),
    );
  }

  List<Widget> _buildFooterLinks(List<String> links) {
    return links.map((link) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // Handle navigation
            },
            child: Text(
              link,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.gray400,
                height: 1.5,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryOrange),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.gray400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray800, width: 1)),
      ),
      child: isMobile
          ? Column(
              children: [
                Text(
                  '© 2026 Labib Rahman. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: AppColors.gray400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBottomLink('Privacy Policy'),
                    const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: AppColors.gray400)),
                    const SizedBox(width: 8),
                    _buildBottomLink('Terms of Service'),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2026 Labib Rahman. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: AppColors.gray400),
                ),
                Row(
                  children: [
                    _buildBottomLink('Privacy Policy'),
                    const SizedBox(width: 24),
                    _buildBottomLink('Terms of Service'),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildBottomLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Handle link tap
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 14, color: AppColors.gray400),
        ),
      ),
    );
  }
}
