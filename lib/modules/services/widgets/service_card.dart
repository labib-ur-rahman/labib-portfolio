import 'package:flutter/material.dart';
import '../../../core/core.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    final cardWidth = isMobile ? 380.0 : (isTablet ? 310.0 : 376.0);
    final cardHeight = isMobile ? 450.0 : (isTablet ? 360.0 : 468.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: cardWidth,
          height: cardHeight,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? (isMobile ? 0 : -20.0) : 0.0),
          child: Stack(
            children: [
              // Card Background with SVG pattern
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    AppAssets.itemServiceCoverArrow,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 24 : 37),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: isMobile ? 24 : 32, // Figma: 32px desktop
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),

                  // Image Section
                  /*Expanded(
                    child: Stack(
                      children: [
                        // Stacked cards effect
                        Positioned(
                          bottom: isMobile ? 20 : 44,
                          left: (cardWidth - (isMobile ? 200 : 308)) / 2,
                          child: Container(
                            width: isMobile ? 200 : 308,
                            height: isMobile ? 200 : 307,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF757575,
                              ).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: isMobile ? 30 : 55,
                          left: (cardWidth - (isMobile ? 250 : 374)) / 2,
                          child: Container(
                            width: isMobile ? 250 : 374,
                            height: isMobile ? 200 : 307,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9E9D9D),
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                        // Main image
                        Positioned(
                          bottom: isMobile ? 40 : 66,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: cardWidth - (isMobile ? 20 : 0),
                              height: isMobile ? 200 : 307,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.asset(
                                  widget.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppColors.gray700,
                                      child: const Center(
                                        child: Icon(
                                          Iconsax.image,
                                          size: 60,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
