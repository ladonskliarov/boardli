import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/style/widgets/custom_button.dart';
import '../../../../core/style/widgets/custom_text_field.dart';
import '../../../../core/util/validator.dart';
import '../cubit/company_management_cubit.dart';

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
              titleColor: Theme.of(context).colorScheme.onSecondary,
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
