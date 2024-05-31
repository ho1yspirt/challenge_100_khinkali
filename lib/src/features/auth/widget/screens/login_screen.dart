import 'package:flutter/material.dart';
import 'package:learn_flutter_aws/src/core/localization/generated/l10n.dart';
import 'package:learn_flutter_aws/src/features/auth/widget/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          Text(
            S.of(context).actionLogin,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16),
          const LoginForm(),
        ]),
      ),
    );
  }
}
