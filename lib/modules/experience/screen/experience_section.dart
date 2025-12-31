import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExperienceController());
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 71,
        vertical: isMobile ? 60 : 85,
      ),
      child: Column(
        children: [
          // Title
          _buildTitle(context),
          SizedBox(height: isMobile ? 40 : 60),

          // Timeline Content
          isMobile
              ? _buildMobileTimeline(context, controller)
              : _buildDesktopTimeline(context, controller),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: isMobile ? 36 : (isTablet ? 48 : 64),
          fontWeight: FontWeight.w500,
          letterSpacing: -0.96,
          height: 1.0,
        ),
        children: const [
          TextSpan(
            text: 'My ',
            style: TextStyle(color: AppColors.gray700),
          ),
          TextSpan(
            text: 'Work Experience',
            style: TextStyle(color: AppColors.primaryOrange),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTimeline(
    BuildContext context,
    ExperienceController controller,
  ) {
    final isTablet = ResponsiveUtils.isTablet(context);

    return SizedBox(
      width: isTablet ? double.infinity : 1298,
      child: Column(
        children: List.generate(
          controller.experiences.length,
          (index) => _buildTimelineRow(
            context,
            controller.experiences[index],
            index == 0,
            index == controller.experiences.length - 1,
            isTablet,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineRow(
    BuildContext context,
    ExperienceModel experience,
    bool isFirst,
    bool isLast,
    bool isTablet,
  ) {
    final nodeSize = isTablet ? 40.0 : 48.0;
    // Increased height to accommodate description text properly
    final itemHeight = isTablet ? 180.0 : 220.0;

    return SizedBox(
      height: itemHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Company Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    experience.company,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: isTablet ? 28 : 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray900,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    experience.duration,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: isTablet ? 18 : 24,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF98A2B3),
                      letterSpacing: -0.36,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center - Timeline Node
          SizedBox(
            width: 88,
            child: Column(
              children: [
                // Top line
                if (!isFirst)
                  Container(width: 2, height: 20, color: AppColors.gray400),
                if (isFirst) const SizedBox(height: 20),

                // Node
                Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    color: experience.isActive
                        ? AppColors.primaryOrange
                        : AppColors.gray900,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: experience.isActive
                          ? AppColors.primaryOrange
                          : AppColors.gray700,
                      width: 3,
                    ),
                  ),
                ),

                // Bottom line
                if (!isLast)
                  Expanded(
                    child: CustomPaint(
                      size: const Size(2, double.infinity),
                      painter: DashedLinePainter(),
                    ),
                  ),
              ],
            ),
          ),

          // Right Column - Role Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    experience.role,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: isTablet ? 28 : 40,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray700,
                      letterSpacing: -0.6,
                    ),
                  ),
                  if (experience.description.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Text(
                      experience.description,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: isTablet ? 16 : 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF98A2B3),
                        letterSpacing: -0.3,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTimeline(
    BuildContext context,
    ExperienceController controller,
  ) {
    return Column(
      children: List.generate(
        controller.experiences.length,
        (index) => _buildMobileExperienceItem(
          context,
          controller.experiences[index],
          index == 0,
          index == controller.experiences.length - 1,
        ),
      ),
    );
  }

  Widget _buildMobileExperienceItem(
    BuildContext context,
    ExperienceModel experience,
    bool isFirst,
    bool isLast,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Node
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: experience.isActive
                      ? AppColors.primaryOrange
                      : AppColors.gray900,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: experience.isActive
                        ? AppColors.primaryOrange
                        : AppColors.gray700,
                    width: 2,
                  ),
                ),
              ),
              if (!isLast)
                SizedBox(
                  width: 2,
                  height: 100,
                  child: CustomPaint(painter: DashedLinePainter()),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.company,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  experience.duration,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF98A2B3),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  experience.role,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryOrange,
                  ),
                ),
                if (experience.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    experience.description,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF98A2B3),
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
