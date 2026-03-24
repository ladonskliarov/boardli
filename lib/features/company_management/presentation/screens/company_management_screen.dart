import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/util/validator.dart';
import '../../../auth/domain/entities/employee_entity.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../../core/style/widgets/custom_dropdown_button.dart';
import '../../../../core/style/widgets/custom_text_field.dart';
import '../../../auth/presentation/constants/enums.dart';
import '../cubit/company_management_cubit.dart';

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
    return BlocProvider(
      create: (context) => sl<CompanyManagementCubit>()..loadOrganizationData(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('company_management.title'.tr(), style: AppTextStyles.regular28),
        ),
        body: Builder(
          builder: (context) {
            return BlocBuilder<CompanyManagementCubit, CompanyManagementState>(
              bloc: context.watch<CompanyManagementCubit>(),
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
                            dividerColor:
                                context.watch<ThemeProvider>().isDarkTheme
                                ? AppColors.metal
                                : AppColors.white,
                            tabs: [
                              Tab(child: Text('company_management.tabs.employees'.tr())),
                              Tab(child: Text('company_management.tabs.departments'.tr())),
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
            );
          },
        ),
      ),
    );
  }
}

class EmployeesTab extends StatelessWidget {
  final List<BaseEmployeeEntity>? employees;
  final List<String>? departments;
  final String? inviteKey;
  const EmployeesTab({
    required this.departments,
    required this.employees,
    this.inviteKey,
    super.key,
  });

  Future<void> _copyInviteKey(BuildContext context, String key) async {
    await Clipboard.setData(ClipboardData(text: key));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('company_management.employees_tab.copy_success'.tr(), style: AppTextStyles.regular16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    final companyManagementCubit = context.read<CompanyManagementCubit>();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: .circular(20),
          ),
          content: Text(
            'company_management.employees_tab.delete_dialog'.tr(),
            style: AppTextStyles.regular18,
          ),
          actions: [
            CustomButton(
              text: 'company_management.employees_tab.delete_confirm'.tr(),
              onPressed: () {
                companyManagementCubit.deleteInviteKey();
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool canAddEmployee(int? departmentsAmount) {
    return departmentsAmount != null && departmentsAmount > 0;
  }

  void _onAddEmployeePressed(BuildContext context, List<String> departments) {
    final CompanyManagementCubit companyManagementCubit = context
        .read<CompanyManagementCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: companyManagementCubit,
          child: AddEmployeeForm(departments: departments),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'company_management.employees_tab.total'.tr(args: [(employees?.length ?? 0).toString()]),
              style: AppTextStyles.regular22,
            ),
            CustomButton(
              text: 'company_management.employees_tab.add_new'.tr(),
              onPressed: () {
                if (canAddEmployee(departments?.length)) {
                  _onAddEmployeePressed(context, departments!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'company_management.employees_tab.no_departments_error'.tr(),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              if (inviteKey != null)
                SliverToBoxAdapter(
                  child: Container(
                    margin: Paddings.paddingVertical20,
                    padding: Paddings.paddingAll12,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: .circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      mainAxisSize: .min,
                      children: [
                        Expanded(
                          child: Text(
                            'company_management.employees_tab.copy_label'.tr(args: [inviteKey!]),
                            maxLines: 4,
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.gunMetal,
                            ),
                            overflow: .ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _copyInviteKey(context, inviteKey!),
                              icon: Icon(Icons.copy, color: AppColors.gunMetal),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _showDeleteConfirmationDialog(context),
                              icon: Icon(Icons.close, color: AppColors.tiger),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (employees != null && employees!.isNotEmpty)
                SliverList.separated(
                  itemCount: employees!.length,
                  itemBuilder: (context, index) {
                    return EmployeeCard(employee: employees![index]);
                  },
                  separatorBuilder: (context, index) {
                    return gapH10;
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class DepartmentsTab extends StatelessWidget {
  final List<String>? departments;
  const DepartmentsTab({required this.departments, super.key});

  void _onAddDepartmentPressed(BuildContext context) {
    final companyManagementCubit = context.read<CompanyManagementCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: companyManagementCubit,
          child: AddDepartmentForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'company_management.departments_tab.total'.tr(args: [(departments?.length ?? 0).toString()]),
              style: AppTextStyles.regular22,
            ),
            CustomButton(
              text: 'company_management.departments_tab.add_new'.tr(),
              onPressed: () {
                _onAddDepartmentPressed(context);
              },
            ),
          ],
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              if (departments != null && departments!.isNotEmpty)
                SliverList.separated(
                  itemCount: departments!.length,
                  itemBuilder: (context, index) {
                    return DepartmentCard(department: departments![index]);
                  },
                  separatorBuilder: (context, index) {
                    return gapH10;
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddEmployeeForm extends StatefulWidget {
  final List<String> departments;
  const AddEmployeeForm({required this.departments, super.key});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<EmployeeRole> _role = ValueNotifier(EmployeeRole.senior);
  late final ValueNotifier<String> _department;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _department = ValueNotifier<String>(widget.departments.first);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _role.dispose();
    _department.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('company_management.add_employee.title'.tr()),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: .min,
            children: [
              CustomTextField(
                title: 'company_management.add_employee.full_name'.tr(),
                titleColor: Theme.of(context).colorScheme.onSecondary,
                controller: _nameController,
                validator: Validator.validateFullName,
              ),
              gapH10,
              CustomTextField(
                title: 'company_management.add_employee.email'.tr(),
                titleColor: Theme.of(context).colorScheme.onSecondary,
                controller: _emailController,
                validator: (value) {
                  return null;
                },
              ),
              gapH10,
              CustomDropdownButton(
                title: 'company_management.add_employee.department'.tr(),
                titleColor: Theme.of(context).colorScheme.onSecondary,
                valueNotifier: _department,
                items: widget.departments,
              ),
              gapH10,
              CustomDropdownButton(
                title: 'company_management.add_employee.role'.tr(),
                titleColor: Theme.of(context).colorScheme.onSecondary,
                valueNotifier: _role,
                items: EmployeeRole.values,
              ),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          text: 'company_management.add_employee.complete'.tr(),
          onPressed: () {
            context.read<CompanyManagementCubit>().createEmployeeInvite(
              name: _nameController.text,
              email: _emailController.text,
              department: _department.value,
              role: _role.value.key,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class AddDepartmentForm extends StatefulWidget {
  const AddDepartmentForm({super.key});

  @override
  State<AddDepartmentForm> createState() => _AddDepartmentFormState();
}

class _AddDepartmentFormState extends State<AddDepartmentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _departmentController = TextEditingController();

  @override
  void dispose() {
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: .min,
          children: [
            CustomTextField(
              title: 'company_management.add_department.name'.tr(),
              validator: Validator.validateDepartmentName,
              controller: _departmentController,
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          text: 'company_management.add_department.complete'.tr(),
          onPressed: () {
            context.read<CompanyManagementCubit>().createDepartment(
              department: _departmentController.text,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final BaseEmployeeEntity employee;
  const EmployeeCard({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Text(
              employee.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regular16,
            ),
          ),
          Expanded(
            child: Text(
              employee.role.value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regular16,
            ),
          ),
        ],
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final String department;
  const DepartmentCard({required this.department, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Text(
              department,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regular20,
            ),
          ),
        ],
      ),
    );
  }
}
