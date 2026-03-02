// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

void hideWebLoader() {
  final loader = html.document.getElementById('loading');
  if (loader == null) return;
  loader.classes.add('fade-out');
  Future<void>.delayed(const Duration(milliseconds: 500), loader.remove);
}
