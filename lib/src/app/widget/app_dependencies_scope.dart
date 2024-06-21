import 'package:flutter/material.dart';
import '../data/app_dependencies.dart';

class AppDependenciesScope extends InheritedWidget {
  const AppDependenciesScope({
    super.key,
    required super.child,
    required this.appDependencies,
  });

  final AppDependencies appDependencies;

  static AppDependencies? maybeOf(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<AppDependenciesScope>()?.widget as AppDependenciesScope?)
        ?.appDependencies;
  }

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError('Out of scope');

  static AppDependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(AppDependenciesScope oldWidget) => false;
}
