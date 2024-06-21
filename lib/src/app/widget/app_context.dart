import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../data/app_dependencies.dart';
import '../../core/localization/generated/l10n.dart';
import '../../features/app/data/models/app_settings_model.dart';

class AppContext extends StatelessWidget {
  const AppContext({
    super.key,
    required this.settingsModel,
  });

  final AppSettingsModel settingsModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // config
      title: 'Flutter + AWS (${AppDependencies.of(context).appConfig.host})',
      debugShowCheckedModeBanner: false,
      // router and navigation
      routerConfig: AppDependencies.of(context).appRouter.router,
      // theme
      theme: AppDependencies.of(context).appTheme.lightThemeData,
      darkTheme: AppDependencies.of(context).appTheme.darkThemeData,
      themeMode: settingsModel.currentThemeMode,
      // locale
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(settingsModel.currentLocale),
    );
  }
}
