import 'package:flutter/material.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';

class AppDependenciesScopeWidget extends InheritedWidget {
  const AppDependenciesScopeWidget({
    super.key,
    required super.child,
    required this.appDependencies,
  });

  final AppDependencies appDependencies;

  static AppDependencies? maybeOf(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<AppDependenciesScopeWidget>()?.widget
            as AppDependenciesScopeWidget?)
        ?.appDependencies;
  }

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError('Out of scope');

  static AppDependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(AppDependenciesScopeWidget oldWidget) => false;
}
