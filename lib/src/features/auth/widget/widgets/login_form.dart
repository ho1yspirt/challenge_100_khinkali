import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/core/components/router/app_router.dart';
import 'package:learn_flutter_aws/src/core/localization/generated/l10n.dart';
import 'package:learn_flutter_aws/src/features/auth/bloc/auth_bloc/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final AuthBloc _authBloc;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _authBloc = AppDependencies.of(context).authBloc;

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthAuthenticated) context.goNamed(Routes.main);

        if (state is AuthUnautheticated) {
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error.toString())),
            );
          }
        }
      },
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (context) => FilledButton.icon(
                onPressed: () {
                  HapticFeedback.heavyImpact();

                  _onLoginFormSubmitted(
                    isValid: Form.of(context).validate(),
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                icon: const Icon(Icons.login_sharp),
                label: Text(S.of(context).actionLogin),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginFormSubmitted({
    required bool isValid,
    required String email,
    required String password,
  }) {
    if (isValid) {
      _authBloc.add(AuthLoggedIn(email: email, password: password));
    }
  }
}
