import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/widgets/app_theme_mode_switch.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: const Icon(CupertinoIcons.map),
          title: Text(S.of(context).appName),
          actions: const [AppThemeModeSwitch()],
        ),
      ]),
    );
  }
}
