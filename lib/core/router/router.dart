import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../features/chat_assistant/presentation/chat_assitant_screen.dart';
import '../../features/company_account/presentation/screens/company_account_screen.dart';
import '../../features/company_management/presentation/screens/company_management_screen.dart';
import '../../features/dashboard/presentation/screens/employee_dashboard_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/screens/company_registration/company_register_screen.dart';
import '../../features/auth/presentation/screens/employee_registration/employee_register_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/dashboard/presentation/screens/company_dashboard_screen.dart';
import '../../features/employee_account/presentation/screens/employee_account_screen.dart';
import '../../features/knowledge_base/presentation/screens/knowledge_base_screen.dart';
import '../di/injection_container.dart';
import '../util/enums.dart';
import 'go_router_refresh_stream.dart';

enum AppPage {
  authorization('/'),
  login('login'),
  registerCompany('company-tariff/register'),
  companyTariff('company-tariff'),
  registerEmployee('register-employee'),

  employeeAccount('/employee-account'),
  employeeChatAssistant('/chat-assistant'),
  employeeKnowledgeBase('/employee-knowledge-base'),
  companyAccount('/company-account'),
  companyManageOrg('/company-organization'),
  companyKnowledgeBase('/company-knowledge-base');

  const AppPage(this.path);
  final String path;
}

final _employeeAccountNavigatorKey = GlobalKey<NavigatorState>();
final _employeeChatAssistantKey = GlobalKey<NavigatorState>();
final _employeeKnowledgeBaseNavigatorKey = GlobalKey<NavigatorState>();

final _companyAccountNavigatorKey = GlobalKey<NavigatorState>();
final _companyManageOrgKey = GlobalKey<NavigatorState>();
final _companyKnowledgeBaseNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPage.authorization.path,
    refreshListenable: GoRouterRefreshStream(sl<AuthCubit>().stream),
    redirect: (context, state) {
      final authState = sl<AuthCubit>().state;
      final currentPath = state.uri.path;

      final bool isAuthRoute =
          currentPath == AppPage.authorization.path ||
          currentPath.startsWith('/${AppPage.login.path}') ||
          currentPath.startsWith('/${AppPage.registerEmployee.path}') ||
          currentPath.startsWith('/${AppPage.companyTariff.path}');

      if ((authState is AuthUnknown || authState is AuthUnauthenticated) &&
          !isAuthRoute) {
        return AppPage.authorization.path;
      }

      if (authState is AuthCompanyAuthenticated && isAuthRoute) {
        return AppPage.companyAccount.path;
      }

      if (authState is AuthEmployeeAuthenticated && isAuthRoute) {
        return AppPage.employeeAccount.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppPage.authorization.path,
        name: AppPage.authorization.name,
        builder: (context, state) {
          return AuthScreen();
        },
        routes: [
          GoRoute(
            path: AppPage.login.path,
            name: AppPage.login.name,
            builder: (context, state) {
              final String userTypeName =
                  state.uri.queryParameters['user-type']!;
              final UserType userType = UserType.values.byName(userTypeName);
              return LoginScreen(userType: userType);
            },
          ),
          GoRoute(
            path: AppPage.registerEmployee.path,
            name: AppPage.registerEmployee.name,
            builder: (context, state) {
              return EmployeeRegisterScreen();
            },
          ),
          GoRoute(
            path: AppPage.registerCompany.path,
            name: AppPage.registerCompany.name,
            builder: (context, state) {
              return CompanyRegisterScreen();
            },
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return EmployeeDashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _employeeAccountNavigatorKey,
            routes: [
              GoRoute(
                path: AppPage.employeeAccount.path,
                name: AppPage.employeeAccount.name,
                builder: (context, state) => EmployeeAccountScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _employeeChatAssistantKey,
            routes: [
              GoRoute(
                path: AppPage.employeeChatAssistant.path,
                name: AppPage.employeeChatAssistant.name,
                builder: (context, state) => EmployeeChatAssistantScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _employeeKnowledgeBaseNavigatorKey,
            routes: [
              GoRoute(
                path: AppPage.employeeKnowledgeBase.path,
                name: AppPage.employeeKnowledgeBase.name,
                builder: (context, state) => KnowledgeBaseScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CompanyDashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _companyAccountNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.companyAccount.path,
                name: AppPage.companyAccount.name,
                builder: (context, state) => CompanyAccountScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _companyManageOrgKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.companyManageOrg.path,
                name: AppPage.companyManageOrg.name,
                builder: (context, state) => CompanyManagementScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _companyKnowledgeBaseNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.companyKnowledgeBase.path,
                name: AppPage.companyKnowledgeBase.name,
                builder: (context, state) => KnowledgeBaseScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
