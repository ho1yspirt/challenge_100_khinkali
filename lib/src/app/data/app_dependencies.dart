import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_flutter_aws/src/features/device/bloc/device/device_bloc.dart';
import 'package:learn_flutter_aws/src/features/device/bloc/list_devices/list_devices_bloc.dart';
import 'package:learn_flutter_aws/src/features/device/data/datasources/device_datasource.dart';
import 'package:learn_flutter_aws/src/features/device/data/repositories/device_repository.dart';
import 'package:learn_flutter_aws/src/features/user/bloc/list_users/list_users_bloc.dart';
import 'package:learn_flutter_aws/src/features/user/bloc/user/user_bloc.dart';
import 'package:learn_flutter_aws/src/features/user/data/datasources/user_datasource.dart';
import 'package:learn_flutter_aws/src/features/user/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/appsync/appsync_service.dart';
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
  late final AppSyncService appSyncService;

  // datasources
  late final AppSettingsDataSource appSettingsDataSource;
  late final AuthDataSource authDataSource;

  late final UserDatasource userDatasource;
  late final DeviceDatasource deviceDatasource;

  // repositories
  late final AppSettingsRepository settingsRepository;
  late final AuthRepository authRepository;

  late final UserRepository userRepository;
  late final DeviceRepository deviceRepository;

  // blocs
  late final AppSettingsBloc appSettingsBloc;
  late final AuthBloc authBloc;

  late final UserBloc userBloc;
  late final ListUsersBloc listUsersBloc;
  late final DeviceBloc deviceBloc;
  late final ListDevicesBloc listDevicesBloc;

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
    appSyncService = AppSyncService$Impl(
      cognitoService,
    )..initialize(
        httpLinkUrl: appConfig.appSyncBaseUrlEndpoint,
        apiKey: appConfig.appSyncApiKey,
      );

    // datasources
    appSettingsDataSource = AppSettingsDataSource$Impl(sharedPreferences);
    authDataSource = AuthDataSource$Impl(flutterSecureStorage);

    userDatasource = UserDatasource$Impl(appSyncService);
    deviceDatasource = DeviceDatasource$Impl(appSyncService);

    // repositories
    settingsRepository = AppSettingsRepository$Impl(appSettingsDataSource);
    authRepository = AuthRepository$Impl(cognitoService, authDataSource);

    userRepository = UserRepository$Impl(userDatasource);
    deviceRepository = DeviceRepository$Impl(deviceDatasource);

    // blocs
    appSettingsBloc = AppSettingsBloc(settingsRepository);
    // create instance of auth blco once
    // and after creation immediately check current authentication status
    authBloc = AuthBloc(authRepository)..add(const AuthStatusChecked());

    userBloc = UserBloc(userRepository);
    listUsersBloc = ListUsersBloc(userRepository);
    deviceBloc = DeviceBloc(deviceRepository);
    listDevicesBloc = ListDevicesBloc(deviceRepository);

    // components
    appRouter = AppRouter(authBloc);
  }
}
