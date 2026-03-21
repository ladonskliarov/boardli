import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/util/validator.dart';
import '../../../authorization/domain/entities/employee_entity.dart';
import '../../../authorization/presentation/widgets/custom_button.dart';
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
        body: BlocBuilder<CompanyManagementCubit, CompanyManagementState>(
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
                        unselectedLabelColor: Colors.grey,
                        labelColor: AppColors.sandyBrown,
                        dividerColor: AppColors.metal,
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
                          ),
                          DepartmentsTab(),
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
      ),
    );
  }
}

class EmployeesTab extends StatelessWidget {
  final List<EmployeeEntity>? employees;
  final List<String>? departments;
  const EmployeesTab({
    required this.departments,
    required this.employees,
    super.key,
  });

  bool canAddEmployee(int? departmentsAmount) {
    return departmentsAmount != null && departmentsAmount > 0;
  }

  void _onAddEmployeePressed(BuildContext context, List<String> departments) {
    showDialog(
      context: context,
      builder: (context) {
        return AddEmployeeForm(departments: departments);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
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
        ),
        if (employees != null && employees!.isNotEmpty)
          SliverList.separated(
            itemBuilder: (context, index) {
              return ListTile(title: Text(employees![index].name));
            },
            separatorBuilder: (context, index) {
              return gapH10;
            },
          ),
      ],
    );
  }
}

class DepartmentsTab extends StatelessWidget {
  const DepartmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return CustomScrollView(
    //   slivers: [
    //     SliverList.separated(
    //       itemBuilder: (context, index) {
    //         return ListTile(title: Text(departments[index]));
    //       },
    //       separatorBuilder: (context, index) {
    //         return gapH10;
    //       },
    //     ),
    //   ],
    // );
  }
}

class AddEmployeeForm extends StatefulWidget {
  final List<String> departments;
  const AddEmployeeForm({required this.departments, super.key});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  // final ValueNotifier<String?> _selectedDepartment = ValueNotifier<String?>(
  //   null,
  // );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Employee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            validator: Validator.validateFullName,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            validator: Validator.validateEmail,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          // CustomDropdownButton(
          //   title: 'Department',
          //   valueNotifier: _selectedDepartment,
          //   items: departments,
          // ),
          TextFormField(decoration: InputDecoration(labelText: 'Role')),
        ],
      ),
      actions: [
        CustomButton(
          text: 'Complete',
          onPressed: () {
            // Handle employee creation logic here
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
