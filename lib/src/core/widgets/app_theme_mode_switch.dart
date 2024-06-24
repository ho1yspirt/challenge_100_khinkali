import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/data/app_dependencies.dart';
import '../../features/app/bloc/app_bloc/app_bloc.dart';

class AppThemeModeSwitch extends StatelessWidget {
  const AppThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppState>(
      bloc: AppDependencies.of(context).appBloc,
      builder: (context, state) => Switch(
        value: state.appSettingsModel.currentThemeMode == ThemeMode.dark,
        onChanged: (value) => AppDependencies.of(context).appBloc.add(
              AppThemeModeChanged(
                value ? ThemeMode.dark : ThemeMode.light,
              ),
            ),
        thumbIcon: WidgetStateProperty.resolveWith((states) {
          if (states.any((materialState) => materialState == WidgetState.selected)) {
            return Icon(
              CupertinoIcons.moon,
              color: Theme.of(context).colorScheme.onSurface,
            );
          } else {
            return const Icon(CupertinoIcons.sun_max);
          }
        }),
      ),
    );
  }
}
