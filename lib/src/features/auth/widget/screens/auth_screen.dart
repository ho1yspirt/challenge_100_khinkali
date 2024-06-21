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
      appBar: AppBar(
        leading: const Icon(Icons.map_sharp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          Text(
            S.of(context).appName,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              HapticFeedback.heavyImpact();
              context.pushNamed(AppRoutes.login);
            },
            icon: const Icon(Icons.login_sharp),
            label: Text(S.of(context).actionLogin),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.login_sharp),
            label: Text(S.of(context).actionSignup),
          ),
        ]),
      ),
    );
  }
}
