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
      child: Column(children: [_buildBottomBar(isMobile)]),
    );
  }

  Widget _buildBottomBar(bool isMobile) {
    final actions = [
      _FooterAction(
        icon: FontAwesomeIcons.github,
        label: 'GitHub',
        onTap: () => _launchUrl('https://github.com/labib-ur-rahman'),
      ),
      _FooterAction(
        icon: FontAwesomeIcons.linkedin,
        label: 'LinkedIn',
        onTap: () => _launchUrl('https://www.linkedin.com/in/labib-ur-rahman'),
      ),
      _FooterAction(
        icon: FontAwesomeIcons.envelope,
        label: 'Email',
        onTap: () => _launchUrl('mailto:contact.labibur@gmail.com'),
      ),
    ];

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
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: actions
                      .map(
                        (action) => _FooterIconButton(
                          icon: action.icon,
                          label: action.label,
                          onTap: action.onTap,
                        ),
                      )
                      .toList(),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2025 - 2026 Labib UR Rahman. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: AppColors.gray400),
                ),
                Row(
                  children: [
                    ...actions
                        .map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: _FooterIconButton(
                              icon: action.icon,
                              label: action.label,
                              onTap: action.onTap,
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
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

class _FooterAction {
  const _FooterAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class _FooterIconButton extends StatefulWidget {
  const _FooterIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterIconButton> createState() => _FooterIconButtonState();
}

class _FooterIconButtonState extends State<_FooterIconButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovering;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Tooltip(
        message: widget.label,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isActive
                  ? AppColors.primaryOrange.withOpacity(0.15)
                  : AppColors.gray900.withOpacity(0.4),
              border: Border.all(
                color: isActive
                    ? AppColors.primaryOrange
                    : AppColors.gray700.withOpacity(0.5),
                width: 1.2,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primaryOrange.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 18,
                color: isActive ? AppColors.primaryOrange : AppColors.gray300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
