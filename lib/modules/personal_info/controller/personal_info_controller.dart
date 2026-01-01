import 'package:get/get.dart';

class PersonalInfoController extends GetxController {
  final RxBool showContent = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Animate content after a delay
    Future.delayed(const Duration(milliseconds: 300), () {
      showContent.value = true;
    });
  }

  // Personal Details
  final String name = 'Md Labibur Rahman';
  final String role = 'Flutter Developer';
  final String email = 'labibur.dev@gmail.com';
  final String phone = '+880 1731-614591';
  final String location = 'Dhaka, Bangladesh';
  final String experience = '5+ Years';
  final String projects = '50+ Projects';

  // About Me
  final String aboutMe =
      '''My name is Labibur Rahman and I specialize in mobile development that utilizes Flutter, Dart, Firebase, and various state management solutions.

I am a highly motivated individual and eternal optimist dedicated to writing clear, concise, robust code that works. Striving to never stop learning and improving with modern development practices and clean architecture principles.

When I'm not coding, I am exploring new Flutter packages, contributing to open-source projects, or picking up new mobile development techniques and UI/UX design trends.

I like to have my perspective and belief systems challenged so that I see the world through new eyes and approach problems with innovative solutions.''';

  final List<PersonalDetail> details = [
    PersonalDetail(
      label: 'Full Name',
      value: 'Md Labibur Rahman',
      icon: 'user',
    ),
    PersonalDetail(label: 'Email', value: 'labibur.dev@gmail.com', icon: 'sms'),
    PersonalDetail(label: 'Phone', value: '+880 1731-614591', icon: 'call'),
    PersonalDetail(
      label: 'Location',
      value: 'Dhaka, Bangladesh',
      icon: 'location',
    ),
    PersonalDetail(label: 'Experience', value: '5+ Years', icon: 'medal_star'),
    PersonalDetail(
      label: 'Projects',
      value: '50+ Completed',
      icon: 'briefcase',
    ),
  ];
}

class PersonalDetail {
  final String label;
  final String value;
  final String icon;

  PersonalDetail({
    required this.label,
    required this.value,
    required this.icon,
  });
}
