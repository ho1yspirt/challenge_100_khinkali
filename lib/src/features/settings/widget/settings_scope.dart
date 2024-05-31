import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/app/widget/app_context.dart';
import 'package:learn_flutter_aws/src/features/settings/bloc/settings_bloc/settings_bloc.dart';
import 'package:learn_flutter_aws/src/features/settings/data/models/settings_model.dart';

class SettingsScopeWidget extends StatelessWidget {
  const SettingsScopeWidget({
    super.key,
    // required this.child,
  });

  // final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: AppDependencies.of(context).settingsBloc,
      builder: (context, state) {
        return InheritedSettingsScopeWidget(
          settingsModel: state.settingsModel,
          child: AppContext(
            settingsModel: state.settingsModel,
          ),
        );
      },
    );
  }
}

class InheritedSettingsScopeWidget extends InheritedWidget {
  const InheritedSettingsScopeWidget({
    super.key,
    required super.child,
    required this.settingsModel,
  });

  final SettingsModel settingsModel;

  static SettingsModel? maybeOf(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<InheritedSettingsScopeWidget>()?.widget
            as InheritedSettingsScopeWidget?)
        ?.settingsModel;
  }

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError('Out of scope');

  static SettingsModel of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedSettingsScopeWidget oldWidget) => settingsModel != oldWidget.settingsModel;
}
