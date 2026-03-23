import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/util/validator.dart';
import '../../../authorization/domain/entities/employee_entity.dart';
import '../../../authorization/presentation/constants/enums.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../../core/style/widgets/custom_dropdown_button.dart';
import '../../../../core/style/widgets/custom_text_field.dart';
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
          title: Text('Manage Company', style: AppTextStyles.regular28),
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
                            color: AppColors.metal,
                            borderRadius: .circular(40),
                          ),
                          height: 44,
                          child: TabBar(
                            indicatorColor: AppColors.sandyBrown,
                            indicatorSize: TabBarIndicatorSize.tab,
                            controller: _tabController,
                            unselectedLabelColor:
                                context.watch<ThemeProvider>().darkTheme
                                ? AppColors.white.withValues(alpha: 0.6)
                                : AppColors.grey,
                            labelColor: AppColors.sandyBrown,
                            dividerColor:
                                context.watch<ThemeProvider>().darkTheme
                                ? AppColors.metal
                                : AppColors.white,
                            tabs: [
                              Tab(child: Text('Employees')),
                              Tab(child: Text('Departments')),
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
      const SnackBar(
        content: Text('Invite key copied', style: AppTextStyles.regular16),
        duration: Duration(seconds: 2),
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
            borderRadius: BorderRadius.circular(20),
          ),
          content: Text(
            'The invite key is shown only once. Are you sure you have saved it and are ready to delete it?',
            style: AppTextStyles.regular18,
          ),
          actions: [
            CustomButton(
              text: 'Yes, delete',
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
              'Total: ${employees?.length ?? 0}',
              style: AppTextStyles.regular22,
            ),
            CustomButton(
              text: 'Add new',
              onPressed: () {
                if (canAddEmployee(departments?.length)) {
                  _onAddEmployeePressed(context, departments!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please create a department before adding employees.',
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
                            'Copy invite key: $inviteKey',
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
              'Total: ${departments?.length ?? 0}',
              style: AppTextStyles.regular22,
            ),
            CustomButton(
              text: 'Add new',
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
      title: Text('Add Employee'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: .min,
            children: [
              CustomTextField(
                title: 'Full name',
                titleColor: AppColors.white,
                controller: _nameController,
                validator: Validator.validateFullName,
              ),
              gapH10,
              CustomTextField(
                title: 'Email',
                titleColor: AppColors.white,
                controller: _emailController,
                validator: (value) {
                  return null;
                },
              ),
              gapH10,
              CustomDropdownButton(
                title: 'Department',
                titleColor: AppColors.white,
                valueNotifier: _department,
                items: widget.departments,
              ),
              gapH10,
              CustomDropdownButton(
                title: 'Role',
                titleColor: AppColors.white,
                valueNotifier: _role,
                items: EmployeeRole.values,
              ),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          text: 'Complete',
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
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              title: 'Department name',
              titleColor: AppColors.white,
              validator: Validator.validateDepartmentName,
              controller: _departmentController,
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          text: 'Complete',
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
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.delete, size: 16),
          // ),
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
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.delete, size: 16),
          // ),
        ],
      ),
    );
  }
}
