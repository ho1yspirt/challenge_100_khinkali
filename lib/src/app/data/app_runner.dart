import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/app/widget/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:learn_flutter_aws/src/app/widget/app_error.dart';

abstract interface class IAppRunner {
  Future<AppDependencies> load();
  void run();
}

class AppRunner implements IAppRunner {
  const AppRunner({
    required this.env,
  });

  final String env;

  @override
  Future<AppDependencies> load() async {
    // initialize project config dependencies
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isAndroid) FlutterDisplayMode.setHighRefreshRate();

    /// preserve for native splash screen
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    }

    await dotenv.load(fileName: ".env");

    // initialize app dependencies
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
    load().then(
      (appDependencies) => runApp(App(
        appDependencies: appDependencies,
      )),
      onError: (error, stackTrace) => runApp(AppError(
        error: error,
      )),
    );
  }
}
