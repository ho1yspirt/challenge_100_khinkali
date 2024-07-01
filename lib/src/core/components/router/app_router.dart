import 'package:go_router/go_router.dart';

import 'app_router_stream.dart';
import '../../../features/auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../features/auth/widget/screens/auth_screen.dart';
import '../../../features/main/widget/screens/main_screen.dart';

final class AppRouter {
  AppRouter(this.authBloc) {
    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppRoutes.main,
      refreshListenable: AppRouterRefreshListenableStream(authBloc.stream),
      redirect: (context, state) {
        final bool authStatus = authBloc.state is Authenticated;

        if (!authStatus) return AppRoutes.auth;

        return null;
      },
      routes: [
        GoRoute(
          name: AppRoutes.main,
          path: AppRoutes.main,
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          name: AppRoutes.auth,
          path: AppRoutes.auth,
          builder: (context, state) => const AuthScreen(),
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
  static const auth = '/auth';
}
