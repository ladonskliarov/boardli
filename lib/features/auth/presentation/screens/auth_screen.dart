import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../widgets/header.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: .center,
              children: [
                gapH206,
                Text(
                  'auth_screen.title'.tr(),
                  style: AppTextStyles.medium20,
                  textAlign: TextAlign.center,
                ),
                gapH54,
                Padding(
                  padding: Paddings.paddingHorizontal20,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('auth_screen.sign_in_as'.tr(), style: AppTextStyles.medium20),
                      gapH22,
                      FittedBox(
                        fit: .scaleDown,
                        child: Row(
                          children: [
                            CustomButton(
                              text: 'auth_screen.employee'.tr(),
                              hasMinimumSize: true,
                              onPressed: () => context.pushNamed(
                                AppPage.login.name,
                                queryParameters: {
                                  'user-type': UserType.employee.name,
                                },
                              ),
                            ),
                            gapW20,
                            CustomButton(
                              text: 'auth_screen.company'.tr(),
                              hasMinimumSize: true,
                              onPressed: () => context.pushNamed(
                                AppPage.login.name,
                                queryParameters: {
                                  'user-type': UserType.company.name,
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      gapH32,
                      Text('auth_screen.sign_up_as'.tr(), style: AppTextStyles.medium20),
                      gapH22,
                      FittedBox(
                        fit: .scaleDown,
                        child: Row(
                          children: [
                            CustomButton(
                              text: 'auth_screen.employee'.tr(),
                              hasMinimumSize: true,
                              onPressed: () => context.pushNamed(
                                AppPage.registerEmployee.name,
                              ),
                            ),
                            gapW20,
                            CustomButton(
                              text: 'auth_screen.company'.tr(),
                              hasMinimumSize: true,
                              onPressed: () =>
                                  context.pushNamed(AppPage.registerCompany.name),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  "© 2026 Don't push the force",
                  style: AppTextStyles.light14,
                ),
                gapH32,
              ],
            ),
          ),
          HeaderWidget(textColor: AppColors.white, isShadow: true),
        ],
      ),
    );
  }
}