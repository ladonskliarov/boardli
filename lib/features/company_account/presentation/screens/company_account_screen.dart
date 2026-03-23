import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../authorization/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../cubit/company_account_cubit.dart';

class CompanyAccountScreen extends StatelessWidget {
  const CompanyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyAccountCubit, CompanyAccountState>(
      builder: (context, state) {
        if (state is CompanyAccountLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CompanyAccountFailure) {
          return Center(child: Text(state.message));
        }
        else if (state is CompanyAccountLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<CompanyAccountCubit>().loadCompanyAccount();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              surfaceTintColor: Colors.transparent,
              title: Text(
                'Company:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: Paddings.paddingHorizontal16,
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    Text(state.companyAccount.name, style: AppTextStyles.light26),
                    gapH12,
                    Divider(),
                    gapH26,
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            Text('Organization size:', style: AppTextStyles.regular24),
                            gapW8,
                            Text(state.companyAccount.size.value, style: AppTextStyles.light24),
                          ],
                        ),
                        gapH4,
                        Row(
                          children: [
                            Text('Email:', style: AppTextStyles.regular24),
                            gapW8,
                            Text(state.companyAccount.email, style: AppTextStyles.light24),
                          ],
                        ),
                        gapH4,
                        Wrap(
                          crossAxisAlignment: .start,
                          children: [
                            Text('Manager:', style: AppTextStyles.regular24),
                            gapW8,
                            Expanded(child: Text(state.companyAccount.contactName, maxLines: 3, style: AppTextStyles.light24)),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                      text: 'Logout',
                      onPressed: () => sl<AuthCubit>().logout(),
                    ),
                    gapH12,
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('Dark mode', style: AppTextStyles.light24),
                        Switch(
                          activeTrackColor: AppColors.sandyBrown,
                          inactiveTrackColor: AppColors.grey,
                          activeThumbColor: AppColors.white,
                          inactiveThumbColor: AppColors.white,
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          thumbIcon: const WidgetStatePropertyAll(
                            Icon(
                              Icons.circle,
                              color: Colors.transparent,
                              size: 0,
                            ),
                          ),
                          value: context.watch<ThemeProvider>().darkTheme,
                          onChanged: (value) {
                            context.read<ThemeProvider>().switchDarkTheme();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('Eng / Ua', style: AppTextStyles.light24),
                        Switch(
                          activeTrackColor: AppColors.sandyBrown,
                          inactiveTrackColor: AppColors.grey,
                          activeThumbColor: AppColors.white,
                          inactiveThumbColor: AppColors.white,
                          thumbIcon: const WidgetStatePropertyAll(
                            Icon(
                              Icons.circle,
                              color: Colors.transparent,
                              size: 0,
                            ),
                          ),
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          value: context.watch<ThemeProvider>().darkTheme,
                          onChanged: (value) {
                            context.read<ThemeProvider>().switchDarkTheme();
                          },
                        ),
                      ],
                    ),
                    gapH24,
                  ],
                ),
              ),
            ),
          ),
        );} else {
          return SizedBox();
        }
      },
    );
  }
}
