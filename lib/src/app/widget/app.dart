import 'package:flutter/material.dart';
import 'package:learn_flutter_aws/src/app/widget/app_dependencies_scope.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/features/settings/widget/settings_scope.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.appDependencies,
  });

  final AppDependencies appDependencies;

  @override
  Widget build(BuildContext context) {
    return AppDependenciesScopeWidget(
      appDependencies: appDependencies,
      child: const SettingsScopeWidget(),
    );
  }
}
