import 'dart:async';

import 'src/app/data/app_runner.dart';
import 'src/core/utils/logger.dart';

Future<void> main() async {
  const env = String.fromEnvironment('env', defaultValue: 'dev');

  runZonedGuarded(
    () => const AppRunner$Impl(env: env).run(),
    (error, stackTrace) => logger.e('AppRunner', error: error, stackTrace: stackTrace),
  );
}
