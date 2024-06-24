import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          title: Text(S.of(context).actionLogin),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: LoginForm(),
          ),
        ),
      ]),
    );
  }
}
