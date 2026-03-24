import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../cubit/company_management_cubit.dart';
import 'tabs/departments_tab.dart';
import 'tabs/employees_tab.dart';

class CompanyManagementScreen extends StatefulWidget {
  const CompanyManagementScreen({super.key});

  @override
  State<CompanyManagementScreen> createState() =>
      _CompanyManagementScreenState();
}

class _CompanyManagementScreenState extends State<CompanyManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'company_management.title'.tr(context: context),
          style: AppTextStyles.regular28,
        ),
      ),
      body: BlocBuilder<CompanyManagementCubit, CompanyManagementState>(
        bloc: context.read<CompanyManagementCubit>(),
        builder: (context, state) {
          if (state is CompanyManagementLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CompanyManagementFailure) {
            return Center(child: Text(state.message));
          } else if (state is CompanyManagementLoaded) {
            return Padding(
              padding: Paddings.paddingHorizontal20,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  gapH10,
                  Container(
                    padding: Paddings.paddingHorizontal20,
                    decoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().isDarkTheme
                          ? AppColors.metal
                          : AppColors.white,
                      borderRadius: .circular(40),
                    ),
                    height: 44,
                    child: TabBar(
                      indicatorColor: AppColors.sandyBrown,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      unselectedLabelColor:
                          context.watch<ThemeProvider>().isDarkTheme
                          ? AppColors.white.withValues(alpha: 0.6)
                          : AppColors.grey,
                      labelColor: AppColors.sandyBrown,
                      dividerColor: context.watch<ThemeProvider>().isDarkTheme
                          ? AppColors.metal
                          : AppColors.white,
                      tabs: [
                        Tab(
                          child: Text('company_management.tabs.employees'.tr(context: context)),
                        ),
                        Tab(
                          child: Text(
                            'company_management.tabs.departments'.tr(context: context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapH20,
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        EmployeesTab(
                          employees: state.employees,
                          departments: state.departments,
                          inviteKey: state.inviteKey,
                        ),
                        DepartmentsTab(departments: state.departments),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
