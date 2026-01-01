import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/contact_me_controller.dart';

class ContactMeSection extends StatelessWidget {
  const ContactMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactMeController());
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 800),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, AppColors.gray900],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
          vertical: isMobile ? 60 : 100,
        ),
        child: Column(
          children: [
            _buildHeader(isMobile, isTablet),
            SizedBox(height: isMobile ? 40 : 60),
            _buildContactContent(controller, isMobile, isTablet),
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
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Contact ',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : (isTablet ? 48 : 64),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                TextSpan(
                  text: 'Me',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : (isTablet ? 48 : 64),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryOrange,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s work together on your next project',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.gray400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactContent(
    ContactMeController controller,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) {
      return Column(
        children: [
          _buildContactInfo(isMobile, isTablet),
          const SizedBox(height: 40),
          _buildContactForm(controller, isMobile, isTablet),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _buildContactInfo(isMobile, isTablet)),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _buildContactForm(controller, isMobile, isTablet),
        ),
      ],
    );
  }

  Widget _buildContactInfo(bool isMobile, bool isTablet) {
    final contactItems = [
      {
        'icon': Iconsax.call,
        'title': 'Phone',
        'value': '+880 1234567890',
        'delay': 0,
      },
      {
        'icon': Iconsax.sms,
        'title': 'Email',
        'value': 'contact@portfolio.com',
        'delay': 100,
      },
      {
        'icon': Iconsax.location,
        'title': 'Address',
        'value': 'Dhaka, Bangladesh',
        'delay': 200,
      },
    ];

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        ...contactItems.map((item) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800 + (item['delay'] as int)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(-50 * (1 - value), 0),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _buildContactItem(
                item['icon'] as IconData,
                item['title'] as String,
                item['value'] as String,
                isMobile,
              ),
            ),
          );
        }).toList(),
        SizedBox(height: isMobile ? 20 : 40),
        _buildSocialLinks(isMobile),
      ],
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String value,
    bool isMobile,
  ) {
    return Row(
      mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryOrange.withOpacity(0.2),
                AppColors.primaryOrange.withOpacity(0.05),
              ],
            ),
          ),
          child: Icon(icon, color: AppColors.primaryOrange, size: 24),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.gray400,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLinks(bool isMobile) {
    final socialLinks = [
      {'icon': Iconsax.global, 'delay': 0},
      {'icon': Iconsax.instagram, 'delay': 50},
      {'icon': Iconsax.send_2, 'delay': 100},
      {'icon': Iconsax.link, 'delay': 150},
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
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryOrange.withOpacity(0.3),
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
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactForm(
    ContactMeController controller,
    bool isMobile,
    bool isTablet,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.gray800.withOpacity(0.5),
          border: Border.all(
            color: AppColors.gray700.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              'Your Name',
              Iconsax.user,
              false,
              (value) => controller.setName(value),
              isMobile,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              'Your Email',
              Iconsax.sms,
              false,
              (value) => controller.setEmail(value),
              isMobile,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              'Your Message',
              Iconsax.message_text,
              true,
              (value) => controller.setMessage(value),
              isMobile,
            ),
            const SizedBox(height: 32),
            Obx(() => _buildSubmitButton(controller, isMobile)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String hint,
    IconData icon,
    bool isMultiLine,
    Function(String) onChanged,
    bool isMobile,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.gray900.withOpacity(0.5),
      ),
      child: TextField(
        onChanged: onChanged,
        maxLines: isMultiLine ? 5 : 1,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.gray400, fontSize: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(icon, color: AppColors.primaryOrange, size: 20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(ContactMeController controller, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: controller.isSubmitting.value ? null : controller.submitForm,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: controller.isSubmitting.value
                  ? [AppColors.gray700, AppColors.gray800]
                  : [
                      AppColors.primaryOrange,
                      AppColors.primaryOrange.withOpacity(0.8),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: controller.isSubmitting.value
                    ? Colors.transparent
                    : AppColors.primaryOrange.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: controller.isSubmitting.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Send Message',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
