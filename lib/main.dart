import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/di/injection_container.dart';
import 'core/providers/theme_provider.dart';
import 'core/router/router.dart';
import 'core/style/app_themes.dart';
import 'features/authorization/presentation/cubits/auth_cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await sl<AuthCubit>().checkAuth();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('uk'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
        create: (_) => sl<ThemeProvider>(),
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  ThemeData _getTheme(BuildContext context) {
    return context.watch<ThemeProvider>().darkTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: _getTheme(context),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
