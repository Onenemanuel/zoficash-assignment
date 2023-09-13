import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import 'package:zoficash/widgets/widgets.dart';

class AppRouter {
  static String initialLocation = LoginScreen.route;

  static final GoRouter router = GoRouter(
    redirect: (context, state) {
      FlutterNativeSplash.remove();
      return;
    },
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: HomeScreen.route,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) {
          return LoadingOverlay(
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: RegisterScreen.route,
        builder: (context, state) {
          return LoadingOverlay(
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: WebViewScreen.route,
        builder: (context, state) {
          return const WebViewScreen();
        },
      ),
      GoRoute(
        path: SecurityQuestionScreen.route,
        builder: (context, state) {
          return LoadingOverlay(
            child: const SecurityQuestionScreen(),
          );
        },
      ),
      GoRoute(
        path: VerificationScreen.route,
        builder: (context, state) {
          return LoadingOverlay(
            child: const VerificationScreen(),
          );
        },
      ),
    ],
  );
}
