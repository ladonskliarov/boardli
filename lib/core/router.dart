import 'package:go_router/go_router.dart';

import '../features/employee_dashboard/presentation/screens/company_dashboard_screen.dart';
import '../features/authorization/presentation/screens/auth_screen.dart';
import '../features/authorization/presentation/screens/company_registration/company_register_screen.dart';
import '../features/authorization/presentation/screens/company_registration/company_tariffs_screen.dart';
import '../features/authorization/presentation/screens/employee_registration/employee_register_screen.dart';
import '../features/authorization/presentation/screens/login/login_screen.dart';
import '../features/company_dashboard/presentation/screens/company_dashboard_screen.dart';

enum AppPage {
  authorization('/'),
  login('login'),
  registerCompany('company-tariff/register'),
  companyTariff('company-tariff'),
  registerEmployee('/register-employee'),

  companyDashboard('/company-dashboard'),
  employeeDashboard('/employee-dashboard');

  const AppPage(this.path);
  final String path;
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPage.authorization.path,
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
              final String userType = state.uri.queryParameters['user-type']!;
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
            path: AppPage.companyTariff.path,
            name: AppPage.companyTariff.name,
            builder: (context, state) {
              return CompanyTariffsScreen();
            },
            routes: [
              GoRoute(
                path: AppPage.registerCompany.path,
                name: AppPage.registerCompany.name,
                builder: (context, state) {
                  return CompanyRegisterScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppPage.employeeDashboard.path,
        name: AppPage.employeeDashboard.name,
        builder: (context, state) {
          return EmployeeDashboardScreen();          
        },
      ),
      GoRoute(
        path: AppPage.companyDashboard.path,
        name: AppPage.companyDashboard.name,
        builder: (context, state) {
          return CompanyDashboardScreen();          
        },
      ),
    ],
  );
}
