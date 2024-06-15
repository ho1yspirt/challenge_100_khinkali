import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/features/settings/bloc/settings_bloc/settings_bloc.dart';

class AppThemeModeSwitch extends StatelessWidget {
  const AppThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: AppDependencies.of(context).settingsBloc,
      builder: (context, state) => Switch(
        value: state.settingsModel.currentThemeMode == ThemeMode.dark,
        onChanged: (value) => AppDependencies.of(context).settingsBloc.add(
              SettingsThemeModeChanged(
                value ? ThemeMode.dark : ThemeMode.light,
              ),
            ),
        thumbIcon: WidgetStateProperty.resolveWith((states) {
          if (states.any((materialState) => materialState == WidgetState.selected)) {
            return const Icon(Icons.dark_mode_sharp);
          } else {
            return const Icon(Icons.light_mode_sharp);
          }
        }),
      ),
    );
  }
}
