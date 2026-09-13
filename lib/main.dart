import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/pages/coming_soon_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NijaaoApp());
}

class NijaaoApp extends StatelessWidget {
  const NijaaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nijaao | Quality Products for a Better Tomorrow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ComingSoonPage(),
    );
  }
}
