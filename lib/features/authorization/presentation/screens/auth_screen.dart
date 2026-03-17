import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/header.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthEmployeeSuccess) {
            context.goNamed(AppPage.companyDashboard.name);
          } else if (state is AuthCompanySuccess) {
            context.goNamed(AppPage.companyDashboard.name);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
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
                                  queryParameters: {'user-type': 'employee'},
                                ),
                              ),
                              gapW20,
                              CustomButton(
                                text: 'Company',
                                onPressed: () => context.pushNamed(
                                  AppPage.login.name,
                                  queryParameters: {'user-type': 'company'},
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
        ),
      ),
    );
  }
}
