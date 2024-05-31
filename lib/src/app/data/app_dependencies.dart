import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_flutter_aws/src/app/data/app_config.dart';
import 'package:learn_flutter_aws/src/app/widget/app_dependencies_scope.dart';
import 'package:learn_flutter_aws/src/core/components/router/app_router.dart';
import 'package:learn_flutter_aws/src/core/components/theme/app_theme.dart';
import 'package:learn_flutter_aws/src/core/services/cognito/cognito.dart';
import 'package:learn_flutter_aws/src/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:learn_flutter_aws/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:learn_flutter_aws/src/features/auth/data/repositories/auth_repository.dart';
import 'package:learn_flutter_aws/src/features/settings/bloc/settings_bloc/settings_bloc.dart';
import 'package:learn_flutter_aws/src/features/settings/data/datasources/settings_datasource.dart';
import 'package:learn_flutter_aws/src/features/settings/data/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependencies {
  AppDependencies();

  factory AppDependencies.of(BuildContext context) => AppDependenciesScopeWidget.of(context);

  // config
  late final IAppConfig appConfig;

  // components
  late final AppRouter appRouter;
  late final AppTheme appTheme;
  late final SharedPreferences sharedPreferences;
  late final FlutterSecureStorage flutterSecureStorage;

  // services
  late final CognitoService cognitoService;

  // datasources
  late final ISettingsDataSource settingsDataSource;
  late final IAuthDataSource authDataSource;

  // repositories
  late final ISettingsRepository settingsRepository;
  late final IAuthRepository authRepository;

  // blocs
  late final SettingsBloc settingsBloc;
  late final AuthBloc authBloc;

  Future<void> initialize(String env) async {
    // config
    appConfig = switch (env) {
      'prod' => ProdAppConfig(),
      'dev' => DevAppConfig(),
      'test' => TestAppConfig(),
      _ => DevAppConfig(),
    };

    // components
    appTheme = AppTheme();
    sharedPreferences = await SharedPreferences.getInstance();
    flutterSecureStorage = const FlutterSecureStorage();

    // services
    cognitoService = CognitoService()
      ..initialize(
        userPoolId: appConfig.cognitoUserPoolId,
        clientId: appConfig.cognitoClientId,
      );

    // datasources
    settingsDataSource = SettingsDataSource(sharedPreferences);
    authDataSource = AuthDataSource(flutterSecureStorage);

    // repositories
    settingsRepository = SettingsRepository(settingsDataSource);
    authRepository = AuthRepository(cognitoService, authDataSource);

    // blocs
    settingsBloc = SettingsBloc(settingsRepository);
    // create instance of auth blco once
    // and after creation immediately check current authentication status
    authBloc = AuthBloc(authRepository)..add(const AuthStatusChecked());

    // components
    appRouter = AppRouter(authBloc);
  }
}
