import 'package:go_router/go_router.dart';
import 'package:learn_flutter_aws/src/core/components/router/app_router_stream.dart';
import 'package:learn_flutter_aws/src/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:learn_flutter_aws/src/features/auth/widget/screens/auth_screen.dart';
import 'package:learn_flutter_aws/src/features/auth/widget/screens/login_screen.dart';
import 'package:learn_flutter_aws/src/features/main/widget/screens/home_screen.dart';
import 'package:learn_flutter_aws/src/features/main/widget/screens/main_screen.dart';

final class AppRouter {
  AppRouter(this.authBloc) {
    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: Routes.main,
      refreshListenable: AppRouterRefreshListenableStream(authBloc.stream),
      redirect: (context, state) {
        final currentLocation = state.matchedLocation;
        final bool authStatus = authBloc.state is AuthAuthenticated;

        if (!authStatus) {
          if (currentLocation.contains(Routes.login)) return null;

          return Routes.auth;
        }

        return null;
      },
      routes: [
        GoRoute(
          name: Routes.main,
          path: Routes.main,
          builder: (context, state) => const MainScreen(),
          routes: [
            GoRoute(
              name: Routes.home,
              path: Routes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        GoRoute(
          name: Routes.auth,
          path: Routes.auth,
          builder: (context, state) => const AuthScreen(),
          routes: [
            GoRoute(
              name: Routes.login,
              path: Routes.login,
              builder: (context, state) => const LoginScreen(),
            ),
          ],
        ),
      ],
    );
  }

  final AuthBloc authBloc;

  late final GoRouter router;
}

final class Routes {
  const Routes._();

  static const main = '/';
  static const home = 'home';
  static const auth = '/auth';
  static const login = 'login';
}
