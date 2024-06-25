import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/data/app_dependencies.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/widgets/app_theme_mode_switch.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';

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
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: FilledButton.icon(
              onPressed: () {
                HapticFeedback.heavyImpact();

                AppDependencies.of(context).authBloc.add(const AuthLoggedOut());
              },
              icon: const Icon(CupertinoIcons.square_arrow_right_fill),
              label: Text(S.of(context).actionLogout),
            ),
          ),
        ),
      ]),
    );
  }
}
