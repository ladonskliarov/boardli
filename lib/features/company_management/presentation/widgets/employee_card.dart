import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../auth/domain/entities/employee_entity.dart';
import '../cubit/company_management_cubit.dart';

class EmployeeCard extends StatelessWidget {
  final BaseEmployeeEntity employee;
  const EmployeeCard({required this.employee, super.key});

  String getDescription() {
    return switch (employee) {
      EmployeeEntity e => e.role.value,
      InvitedEmployeeEntity _ =>
        'company_management.employees_tab.status_invited'.tr(),
      _ => 'company_management.employees_tab.status_unknown'.tr(),
    };
  }

  void _showDeleteConfirmationDialog(BuildContext context, String employeeId) {
    final companyManagementCubit = context.read<CompanyManagementCubit>();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: companyManagementCubit,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: .circular(20)),
            content: Text(
              'company_management.employees_tab.delete_employee_dialog'.tr(),
              style: AppTextStyles.regular18,
            ),
            actions: [
              CustomButton(
                text: 'company_management.employees_tab.delete_confirm'.tr(),
                onPressed: () {
                  companyManagementCubit.deleteEmployee(employeeId: employeeId);
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: .start,
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            flex: 80,
            child: Column(
              crossAxisAlignment: .start,
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
                    getDescription(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regular16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context, employee.id);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
