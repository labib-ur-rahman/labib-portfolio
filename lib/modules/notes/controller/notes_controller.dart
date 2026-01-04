import 'dart:async';
import 'package:get/get.dart';

class NoteModel {
  final String title;
  final String description;
  final List<String> platforms;
  final List<String> technologies;
  final String image;
  final String? link;

  NoteModel({
    required this.title,
    required this.description,
    required this.platforms,
    required this.technologies,
    required this.image,
    this.link,
  });
}

class NotesController extends GetxController {
  final currentPage = 0.obs;
  final RxBool showContent = false.obs;
  Timer? _autoScrollTimer;
  int maxPages = 9;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      showContent.value = true;
    });
    startAutoScroll();
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    super.onClose();
  }

  void startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage.value < maxPages - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
    });
  }

  void setMaxPages(int pages) {
    maxPages = pages;
    if (currentPage.value >= maxPages) {
      currentPage.value = 0;
    }
  }

  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  void resumeAutoScroll() {
    startAutoScroll();
  }

  final List<NoteModel> notes = [
    NoteModel(
      title: '*Design Unraveled*: Behind the Scenes of UI/UX Magic',
      description:
          'A comprehensive design exploration showcasing modern UI/UX principles and creative workflows',
      platforms: ['Android', 'iOS'],
      technologies: ['Flutter', 'Firebase', 'Dart'],
      image: 'assets/images/project1.png',
      link: 'https://example.com/project1',
    ),
    NoteModel(
      title: '*Sugee*: Loan Management System for Rural Sector',
      description:
          'Revolutionary loan management platform designed specifically for rural banking operations',
      platforms: ['Android'],
      technologies: ['Flutter', 'Dart', 'RestAPI'],
      image: 'assets/images/project2.png',
      link: 'https://example.com/project2',
    ),
    NoteModel(
      title: '*Cinetrade*: Innovative way to invest in Digital Media',
      description:
          'Investment platform connecting digital media creators with investors through blockchain',
      platforms: ['Android', 'iOS', 'Web'],
      technologies: ['Flutter', 'Kotlin', 'Dart'],
      image: 'assets/images/project3.png',
      link: 'https://example.com/project3',
    ),
  ];

  void changePage(int index) {
    stopAutoScroll();
    currentPage.value = index;
    resumeAutoScroll();
  }

  void nextNote() {
    stopAutoScroll();
    if (currentPage.value < notes.length - 1) {
      currentPage.value++;
    }
    resumeAutoScroll();
  }

  void previousNote() {
    stopAutoScroll();
    if (currentPage.value > 0) {
      currentPage.value--;
    }
    resumeAutoScroll();
  }
}
