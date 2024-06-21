import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/services/cognito/cognito_service.dart';
import '../widget/app_dependencies_scope.dart';
import '../../core/components/router/app_router.dart';
import '../../core/components/theme/app_theme.dart';
import '../../core/services/cognito/cognito_service.dart';
import '../../features/auth/bloc/auth_bloc/auth_bloc.dart';
import '../../features/auth/data/datasources/auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/app/bloc/app_bloc/app_bloc.dart';
import '../../features/app/data/datasources/app_settings_datasource.dart';
import '../../features/app/data/repositories/app_settings_repository.dart';
import 'app_config.dart';

class AppDependencies {
  AppDependencies();

  factory AppDependencies.of(BuildContext context) => AppDependenciesScope.of(context);

  // config
  late final AppConfig appConfig;

  // components
  late final AppRouter appRouter;
  late final AppTheme appTheme;

  late final SharedPreferences sharedPreferences;
  late final FlutterSecureStorage flutterSecureStorage;

  // services
  late final CognitoService cognitoService;

  // datasources
  late final AppSettingsDataSource appSettingsDataSource;
  late final AuthDataSource authDataSource;

  // repositories
  late final AppSettingsRepository settingsRepository;
  late final AuthRepository authRepository;

  // blocs
  late final AppSettingsBloc appBloc;
  late final AuthBloc authBloc;

  Future<void> initialize(String env) async {
    // config
    appConfig = switch (env) {
      'prod' => Prod$AppConfig$Impl(),
      'dev' => Dev$AppConfig$Impl(),
      'test' => Test$AppConfig$Impl(),
      _ => Dev$AppConfig$Impl(),
    };

    // components
    appTheme = AppTheme();

    sharedPreferences = await SharedPreferences.getInstance();
    flutterSecureStorage = const FlutterSecureStorage();

    // services
    cognitoService = CognitoService$Impl()
      ..initialize(
        userPoolId: appConfig.cognitoUserPoolId,
        clientId: appConfig.cognitoClientId,
      );

    // datasources
    appSettingsDataSource = AppSettingsDataSource$Impl(sharedPreferences);
    authDataSource = AuthDataSource$Impl(flutterSecureStorage);

    // repositories
    settingsRepository = AppSettingsRepository$Impl(appSettingsDataSource);
    authRepository = AuthRepository$Impl(cognitoService, authDataSource);

    // blocs
    appBloc = AppSettingsBloc(settingsRepository);
    // create instance of auth blco once
    // and after creation immediately check current authentication status
    authBloc = AuthBloc(authRepository)..add(const AuthStatusChecked());

    // components
    appRouter = AppRouter(authBloc);
  }
}
