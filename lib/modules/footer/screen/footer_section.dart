import 'package:flutter/material.dart';
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
