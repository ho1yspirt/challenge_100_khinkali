import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../main.dart';
import '../../core/utils/logger.dart';
import '../data/app_config.dart';
import '../widget/app.dart';
import '../widget/app_error.dart';
import 'app_dependencies.dart';

/// Application runner class, that contains all necessary methods to run Flutter application
abstract interface class AppRunner {
  /// Initialize application integrations initializations
  /// with application dependencies that are contains in [AppDependencies] class
  Future<AppDependencies> initialize();

  /// Run application, [run] method is a wrapper of [runApp],
  ///  that needs to be executed after async [initialize] method of [AppRunner] class
  void run();
}

/// Implementation of [AppRunner]
class AppRunner$Impl implements AppRunner {
  const AppRunner$Impl({
    required this.env,
  });

  /// Application environment definition variable
  /// Comes from [main] - [env] const of [String.fromEnvironment]
  ///
  /// [env] defines application's [AppConfig] in [AppDependencies.initialize]
  ///
  /// If value is `prod` then [appConfig] of [AppDependencies] will be [Prod$AppConfig$Impl]
  ///
  /// If value is `dev` then [appConfig] of [AppDependencies] will be [Dev$AppConfig$Impl]
  ///
  /// If value is `test` then [appConfig] of [AppDependencies] will be [Test$AppConfig$Impl]
  ///
  /// By default value is set to [Dev$AppConfig$Impl]
  final String env;

  @override
  Future<AppDependencies> initialize() async {
    // Initialize project config dependencies
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve for native splash screen
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    }

    // Log errors and exceptions with PlatformDispatcher
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      logger.e(runtimeType, error: error, stackTrace: stackTrace);

      return true;
    };

    FlutterError.onError = (details) {
      FlutterError.presentError(details);

      logger.e(runtimeType, error: details.exception, stackTrace: details.stack);
    };

    // Set high refresh rate only for android platform
    if (Platform.isAndroid) FlutterDisplayMode.setHighRefreshRate();

    // Load .env file
    await dotenv.load(fileName: ".env");

    // Initialize Hive NoSQL DB for storing GraphQL client's cache
    // Hive itself destructive library, but for client's purpouses it maybe tolerable
    await initHiveForFlutter();

    // Initialize application global dependencies
    final AppDependencies appDependencies = AppDependencies();
    await appDependencies.initialize(env);

    /// End splash screen after application initialization process
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      FlutterNativeSplash.remove();
    }

    // Return application dependencies, so [App] widget in [runApp] can consume them
    return appDependencies;
  }

  @override
  void run() {
    initialize().then(
      (appDependencies) => runApp(App(
        appDependencies: appDependencies,
      )),
      onError: (error, stackTrace) => runApp(AppError(
        error: error,
      )),
    );
  }
}
