import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/router/app_router.dart';
import '../../../../core/localization/generated/l10n.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: const Icon(CupertinoIcons.map),
          title: Text(S.of(context).appName),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Column(children: [
              FilledButton.icon(
                onPressed: () {
                  HapticFeedback.heavyImpact();

                  context.pushNamed(AppRoutes.login);
                },
                icon: const Icon(CupertinoIcons.square_arrow_right_fill),
                label: Text(S.of(context).actionLogin),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(CupertinoIcons.square_arrow_right),
                label: Text(S.of(context).actionSignup),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
