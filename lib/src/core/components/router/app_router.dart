import 'package:go_router/go_router.dart';
import 'app_router_stream.dart';
import '../../../features/auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../features/auth/widget/screens/auth_screen.dart';
import '../../../features/auth/widget/screens/login_screen.dart';
import '../../../features/main/widget/screens/home_screen.dart';
import '../../../features/main/widget/screens/main_screen.dart';

final class AppRouter {
  AppRouter(this.authBloc) {
    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppRoutes.main,
      refreshListenable: AppRouterRefreshListenableStream(authBloc.stream),
      redirect: (context, state) {
        final currentLocation = state.matchedLocation;
        final bool authStatus = authBloc.state is Authenticated;

        if (!authStatus) {
          if (currentLocation.contains(AppRoutes.login)) return null;

          return AppRoutes.auth;
        }

        return null;
      },
      routes: [
        GoRoute(
          name: AppRoutes.main,
          path: AppRoutes.main,
          builder: (context, state) => const MainScreen(),
          routes: [
            GoRoute(
              name: AppRoutes.home,
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        GoRoute(
          name: AppRoutes.auth,
          path: AppRoutes.auth,
          builder: (context, state) => const AuthScreen(),
          routes: [
            GoRoute(
              name: AppRoutes.login,
              path: AppRoutes.login,
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

final class AppRoutes {
  const AppRoutes._();

  static const main = '/';
  static const home = 'home';
  static const auth = '/auth';
  static const login = 'login';
}
