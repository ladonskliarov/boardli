import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../../core/style/widgets/custom_dropdown_button.dart';
import '../../../../core/style/widgets/custom_text_field.dart';
import '../../../../core/util/validator.dart';
import '../../../auth/presentation/constants/enums.dart';
import '../cubit/company_management_cubit.dart';

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