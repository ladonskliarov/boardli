import 'package:go_router/go_router.dart';

import '../features/authorization/presentation/screens/authorization_screen.dart';

enum AppPage {
  authorization('/'),
  registerCompany('/register-company'),
  registerEmployee('/register-employee'),
  loginCompany('/login-company'),
  loginEmployee('/login-employee'),

  homeCompany('/home-company'),
  homeEmployee('/home-employee');

  const AppPage(this.path);
  final String path;
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPage.authorization.path,
    routes: [
      GoRoute(
        name: 'authorization',
        path: AppPage.authorization.path,
        builder: (context, state) { 
          return AuthorizationScreen();
        }
      ),
    ],
  );
}