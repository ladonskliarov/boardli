import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../authorization/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../cubit/employee_account_cubit.dart';

class EmployeeAccountScreen extends StatelessWidget {
  const EmployeeAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Paddings.paddingHorizontal20,
          child: BlocBuilder<EmployeeAccountCubit, EmployeeAccountState>(
            bloc: context.read<EmployeeAccountCubit>(),
            builder: (context, state) {
              if (state is EmployeeAccountLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EmployeeAccountLoaded) {
                return Column(
                  mainAxisSize: .min,
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  children: [
                    gapH12,
                    Row(
                      children: [
                        AvatarWidget(
                          avatarUrl: state.employee.avatarUrl,
                        ),
                        gapW20,
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text('Boardler:', style: AppTextStyles.regular28),
                            Text(state.employee.name, style: AppTextStyles.light22),
                            Text(state.employee.secondName, style: AppTextStyles.light22),
                          ],
                        ),
                      ],
                    ),
                    gapH26,
                    Divider(height: 3, thickness: 3, color: Theme.of(context).dividerColor),
                    gapH26,
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            Text('Company:', style: AppTextStyles.regular24),
                            gapW8,
                            Text('Empat [Mock]', style: AppTextStyles.light24),
                          ],
                        ),
                        gapH4,
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text('Department:', style: AppTextStyles.regular24),
                            Text(state.employee.department, style: AppTextStyles.light24),
                          ],
                        ),
                        gapH4,
                        Row(
                          children: [
                            Text('Role:', style: AppTextStyles.regular24),
                            gapW8,
                            Text(state.employee.role.value, style: AppTextStyles.light24),
                          ],
                        ),
                        gapH10,
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
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  const AvatarWidget({required this.avatarUrl, super.key});

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return Container(
        width: 144,
        height: 144,
        padding: .all(6),
        decoration: BoxDecoration(
          color: AppColors.softLinen,
          shape: BoxShape.circle,
        ),
        child: ClipOval(child: Image.network(avatarUrl!, fit: BoxFit.cover)),
      );
    }
    return CircleAvatar(
      radius: 72,
      backgroundColor: AppColors.grey,
      child: Icon(Icons.person),
    );
  }
}
