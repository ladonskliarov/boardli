import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../auth/presentation/cubits/auth_cubit/auth_cubit.dart';
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
        } else if (state is CompanyAccountLoaded) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: Paddings.paddingHorizontal16,
                child: RefreshIndicator(
                  color: AppColors.sandyBrown,
                  onRefresh: () async {
                    context.read<CompanyAccountCubit>().refreshCompanyAccount();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          crossAxisAlignment: .center,
                          children: [
                            Flexible(
                              flex: 60,
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    'company_account.title'.tr(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                    overflow: .ellipsis,
                                  ),
                                  gapH4,
                                  FittedBox(
                                    child: Text(
                                      state.companyAccount.name,
                                      style: AppTextStyles.light26,
                                      overflow: .ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 40,
                              child: CustomButton(
                                text: 'company_account.logout'.tr(),
                                onPressed: () => sl<AuthCubit>().logout(),
                              ),
                            ),
                          ],
                        ),
                        gapH12,
                        Divider(),
                        gapH12,
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'company_account.organization_size'.tr(),
                                  style: AppTextStyles.regular24,
                                  overflow: .ellipsis,
                                ),
                                gapW8,
                                Text(
                                  state.companyAccount.size.value,
                                  style: AppTextStyles.light24,
                                  overflow: .ellipsis,
                                ),
                              ],
                            ),
                            gapH4,
                            Row(
                              children: [
                                Text(
                                  'company_account.email'.tr(),
                                  style: AppTextStyles.regular24,
                                  overflow: .ellipsis,
                                ),
                                gapW8,
                                Expanded(
                                  child: Text(
                                    state.companyAccount.email,
                                    style: AppTextStyles.light24,
                                    overflow: .ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            gapH4,
                            Wrap(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  'company_account.manager'.tr(),
                                  style: AppTextStyles.regular24,
                                  overflow: .ellipsis,
                                ),
                                gapW8,
                                Text(
                                  state.companyAccount.contactName,
                                  maxLines: 3,
                                  style: AppTextStyles.light24,
                                  overflow: .ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        gapH250,
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'company_account.dark_mode'.tr(),
                              style: AppTextStyles.light24,
                              overflow: .ellipsis,
                            ),
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
                              value: context.watch<ThemeProvider>().isDarkTheme,
                              onChanged: (value) {
                                context.read<ThemeProvider>().switchDarkTheme();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'company_account.language_toggle'.tr(),
                              style: AppTextStyles.light24,
                              overflow: .ellipsis,
                            ),
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
                              value: context
                                  .watch<LocaleProvider>()
                                  .isUkrainian,
                              onChanged: (value) {
                                context.read<LocaleProvider>().switchLocale(
                                  context,
                                );
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
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
