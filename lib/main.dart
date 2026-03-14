import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/di/injection_container.dart';
import 'core/providers/theme_provider.dart';
import 'core/router.dart';
import 'core/storage/interfaces/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDI();

  final LocalStorageService localStorageService = di<LocalStorageService>();
  final darkTheme = await localStorageService.getDarkTheme();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('uk'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(darkTheme: darkTheme),
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
