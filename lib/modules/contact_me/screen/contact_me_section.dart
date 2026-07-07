import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
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
                  text: 'Get ',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : (isTablet ? 48 : 64),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                TextSpan(
                  text: 'In Touch',
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
            'Let\'s discuss your next project',
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
        'icon': FontAwesomeIcons.phone,
        'title': 'Phone',
        'value': '+880 1602475999',
        'delay': 0,
      },
      {
        'icon': FontAwesomeIcons.solidEnvelope,
        'title': 'Email',
        'value': 'contact.labibur@gmail.com',
        'delay': 100,
      },
      {
        'icon': FontAwesomeIcons.locationDot,
        'title': 'Address',
        'value': 'Nikunja 2, Khilkhet, Dhaka, Bangladesh',
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
                item['icon'] as FaIconData,
                item['title'] as String,
                item['value'] as String,
                isMobile,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildContactItem(
    FaIconData icon,
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
                AppColors.primaryOrange.withValues(alpha: 0.2),
                AppColors.primaryOrange.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Center(child: FaIcon(icon, color: AppColors.primaryOrange, size: 24)),
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
          color: AppColors.gray800.withValues(alpha: 0.5),
          border: Border.all(
            color: AppColors.gray700.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              'Your Name',
              FontAwesomeIcons.solidUser,
              false,
              controller.nameTextController,
              (value) => controller.setName(value),
              isMobile,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              'Your Email',
              FontAwesomeIcons.solidEnvelope,
              false,
              controller.emailTextController,
              (value) => controller.setEmail(value),
              isMobile,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              'Subject',
              FontAwesomeIcons.solidNoteSticky,
              false,
              controller.subjectTextController,
              (value) => controller.setSubject(value),
              isMobile,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              'Your Message',
              FontAwesomeIcons.solidComment,
              true,
              controller.messageTextController,
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
    FaIconData icon,
    bool isMultiLine,
    TextEditingController controller,
    Function(String) onChanged,
    bool isMobile,
  ) {
    return _ContactInputField(
      hint: hint,
      icon: icon,
      isMultiLine: isMultiLine,
      controller: controller,
      onChanged: onChanged,
      isMobile: isMobile,
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
                      AppColors.primaryOrange.withValues(alpha: 0.8),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: controller.isSubmitting.value
                    ? Colors.transparent
                    : AppColors.primaryOrange.withValues(alpha: 0.3),
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
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidPaperPlane,
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _ContactInputField extends StatefulWidget {
  const _ContactInputField({
    required this.hint,
    required this.icon,
    required this.isMultiLine,
    required this.controller,
    required this.onChanged,
    required this.isMobile,
  });

  final String hint;
  final FaIconData icon;
  final bool isMultiLine;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool isMobile;

  @override
  State<_ContactInputField> createState() => _ContactInputFieldState();
}

class _ContactInputFieldState extends State<_ContactInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovering || _focusNode.hasFocus;

    return MouseRegion(
      cursor: SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.gray900.withValues(alpha: 0.55),
          border: Border.all(
            color: isActive
                ? AppColors.primaryOrange
                : AppColors.gray700.withValues(alpha: 0.5),
            width: 1.2,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primaryOrange.withValues(alpha: 0.2),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: TextField(
          focusNode: _focusNode,
          controller: widget.controller,
          onChanged: widget.onChanged,
          maxLines: widget.isMultiLine ? 3 : 1,
          keyboardType: widget.hint == 'Your Email'
              ? TextInputType.emailAddress
              : TextInputType.text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: AppColors.gray400, fontSize: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: FaIcon(
                widget.icon,
                color: AppColors.primaryOrange,
                size: 20,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 18 : 20,
              vertical: widget.isMultiLine ? 18 : 20,
            ),
          ),
        ),
      ),
    );
  }
}
