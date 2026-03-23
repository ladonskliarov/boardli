import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_icons.dart';
import '../../../company_account/presentation/cubit/company_account_cubit.dart';
import '../../../company_management/presentation/cubit/company_management_cubit.dart';
import '../../../knowledge_base/presentation/cubit/knowledge_base_cubit.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_bottom_bar_item.dart';

class CompanyDashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CompanyDashboardScreen({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<CompanyAccountCubit>()..loadCompanyAccount(), lazy: false),
        BlocProvider(create: (_) => sl<CompanyManagementCubit>()..loadOrganizationData(), lazy: false),
        BlocProvider(create: (_) => sl<KnowledgeBaseCubit>()..getResources(), lazy: false),
      ],
      child: Scaffold(
        backgroundColor: context.watch<ThemeProvider>().darkTheme ? AppColors.gunMetal : AppColors.softLinen,
        body: navigationShell,
        bottomNavigationBar: CustomBottomBar(
          bottomBarItems: [
          CustomBottomBarItem(
            iconPath: AppIcons.company,
            isSelected: navigationShell.currentIndex == 0,
            onTap: () => navigationShell.goBranch(0),
          ),
          CustomBottomBarItem(
            iconPath: AppIcons.organization,
            isSelected: navigationShell.currentIndex == 1,
            onTap: () => navigationShell.goBranch(1),
          ),
          CustomBottomBarItem(
            iconPath: AppIcons.upload,
            isSelected: navigationShell.currentIndex == 2,
            onTap: () => navigationShell.goBranch(2),
          ),
        ],
        ),
      ),
    );
  }
}
