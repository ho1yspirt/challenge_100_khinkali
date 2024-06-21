import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_context.dart';
import 'app_dependencies_scope.dart';
import '../data/app_dependencies.dart';
import '../../features/app/bloc/app_bloc/app_bloc.dart';
import '../../features/app/widget/app_settings_scope.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.appDependencies,
  });

  final AppDependencies appDependencies;

  @override
  Widget build(BuildContext context) {
    return AppDependenciesScope(
      appDependencies: appDependencies,
      child: BlocBuilder<AppSettingsBloc, AppState>(
        bloc: appDependencies.appBloc,
        builder: (context, state) => AppSettingsScope(
          appSettingsModel: state.appSettingsModel,
          child: AppContext(
            settingsModel: state.appSettingsModel,
          ),
        ),
      ),
    );
  }
}
