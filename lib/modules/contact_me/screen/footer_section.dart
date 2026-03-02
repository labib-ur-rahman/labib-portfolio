import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      // child: Column(children: [_buildSocialLinks(isMobile)]),
      child: Column(children: [_buildBottomBar(isMobile)]),
    );
  }

  Widget _buildSocialLinks(bool isMobile) {
    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'label': 'GitHub',
        'onTap': () => _launchUrl('https://github.com/labib-ur-rahman'),
        'delay': 0,
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'label': 'LinkedIn',
        'onTap': () =>
            _launchUrl('https://www.linkedin.com/in/labib-ur-rahman'),
        'delay': 50,
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'label': 'Email',
        'onTap': () => _launchUrl('mailto:contact.labibur@gmail.com'),
        'delay': 100,
      },
      {
        'icon': FontAwesomeIcons.link,
        'label': 'Portfolio',
        'onTap': () => _launchUrl('#'),
        'delay': 150,
      },
    ];

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Wrap(
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        spacing: 16,
        children: socialLinks.map((link) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800 + (link['delay'] as int)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Tooltip(
                message: link['label'] as String,
                child: GestureDetector(
                  onTap: () => (link['onTap'] as VoidCallback)(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryOrange.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      link['icon'] as IconData,
                      color: AppColors.primaryOrange,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
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
                  '© 2025 - 2026 Labib UR Rahman. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: AppColors.gray400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                _buildSocialLinks(isMobile),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2025 - 2026 Labib UR Rahman. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: AppColors.gray400),
                ),
                _buildSocialLinks(isMobile),
              ],
            ),
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class BackToTopFloatingButton extends StatefulWidget {
  const BackToTopFloatingButton({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<BackToTopFloatingButton> createState() =>
      _BackToTopFloatingButtonState();
}

class _BackToTopFloatingButtonState extends State<BackToTopFloatingButton> {
  bool _isVisible = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(covariant BackToTopFloatingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_handleScroll);
      widget.scrollController.addListener(_handleScroll);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  void _handleScroll() {
    final show =
        widget.scrollController.hasClients &&
        widget.scrollController.offset > 200;
    if (show != _isVisible) {
      setState(() => _isVisible = show);
    } else {
      setState(() {});
    }
  }

  Future<void> _scrollToTop() async {
    if (widget.scrollController.hasClients) {
      setState(() => _isPressed = true);
      await widget.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      if (mounted) {
        setState(() => _isPressed = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        widget.scrollController.hasClients &&
            widget.scrollController.position.maxScrollExtent > 0
        ? (widget.scrollController.offset /
                  widget.scrollController.position.maxScrollExtent)
              .clamp(0.0, 1.0)
        : 0.0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isVisible ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !_isVisible,
        child: GestureDetector(
          onTap: _scrollToTop,
          onLongPress: _scrollToTop,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4,
                  backgroundColor: AppColors.borderDark.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryOrange,
                  ),
                ),
              ),
              AnimatedScale(
                duration: const Duration(milliseconds: 160),
                scale: _isPressed ? 0.85 : 1.0,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.angleUp,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
