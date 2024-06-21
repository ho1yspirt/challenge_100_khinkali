import 'package:flutter/material.dart';
import '../../../../core/widgets/app_theme_mode_switch.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          AppThemeModeSwitch(),
        ],
      ),
    );
  }
}
