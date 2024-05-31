import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/core/localization/generated/l10n.dart';
import 'package:learn_flutter_aws/src/features/settings/data/models/settings_model.dart';

class AppContext extends StatelessWidget {
  const AppContext({
    super.key,
    required this.settingsModel,
  });

  final SettingsModel settingsModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // config
      title: 'Flutter + AWS (${AppDependencies.of(context).appConfig.host})',
      debugShowCheckedModeBanner: false,
      routerConfig: AppDependencies.of(context).appRouter.router,
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
