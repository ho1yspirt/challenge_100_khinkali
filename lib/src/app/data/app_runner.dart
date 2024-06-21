import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app_dependencies.dart';
import '../widget/app.dart';
import '../widget/app_error.dart';

abstract interface class AppRunner {
  Future<AppDependencies> initialize();

  void run();
}

class AppRunner$Impl implements AppRunner {
  const AppRunner$Impl({
    required this.env,
  });

  final String env;

  @override
  Future<AppDependencies> initialize() async {
    // initialize project config dependencies
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    // preserve for native splash screen
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    }

    // set high refresh rate only for android platform
    if (Platform.isAndroid) FlutterDisplayMode.setHighRefreshRate();

    // load .env file
    await dotenv.load(fileName: ".env");

    // init Hive NoSQL DB for storing GraphQL client's cache
    // Hive itself destructive library, but for client's purpouses it maybe tolerable
    await initHiveForFlutter();

    // initialize application global dependencies
    final AppDependencies appDependencies = AppDependencies();
    await appDependencies.initialize(env);

    /// End splash screen after application initialization process
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      FlutterNativeSplash.remove();
    }

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
