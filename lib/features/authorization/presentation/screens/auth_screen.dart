import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/util/enums.dart';
import '../widgets/custom_button.dart';
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
                  'Onboarding. AI-driven.\nPocket Sized.',
                  style: AppTextStyles.medium20,
                  textAlign: .center,
                ),
                gapH54,
                Padding(
                  padding: Paddings.paddingHorizontalL,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Sign in as', style: AppTextStyles.medium20),
                      gapH22,
                      Row(
                        children: [
                          CustomButton(
                            text: 'Employee',
                            onPressed: () => context.pushNamed(
                              AppPage.login.name,
                              queryParameters: {'user-type': UserType.employee.name},
                            ),
                          ),
                          gapW20,
                          CustomButton(
                            text: 'Company',
                            onPressed: () => context.pushNamed(
                              AppPage.login.name,
                              queryParameters: {'user-type': UserType.company.name},
                            ),
                          ),
                        ],
                      ),
                      gapH32,
                      Text('Sign up as', style: AppTextStyles.medium20),
                      gapH22,
                      Row(
                        children: [
                          CustomButton(
                            text: 'Employee',
                            onPressed: () => context.pushNamed(
                              AppPage.registerEmployee.name,
                            ),
                          ),
                          gapW20,
                          CustomButton(
                            text: 'Company',
                            onPressed: () => context.pushNamed(
                              AppPage.companyTariff.name,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "© 2026 Don't push the force",
                  style: AppTextStyles.light14,
                ),
                gapH32,
              ],
            ),
          ),
          HeaderWidget(isShadow: true),
        ],
      ),
    );
  }
}
