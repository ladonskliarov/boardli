import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/style/app_text_styles.dart';
import '../../../../../core/style/widgets/custom_button.dart';
import '../../../../../core/util/extensions.dart';
import '../../../../auth/domain/entities/employee_entity.dart';
import '../../components/add_employee_form.dart';
import '../../cubit/company_management_cubit.dart';
import '../../widgets/employee_card.dart';

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
        content: Text(
          'company_management.employees_tab.copy_success'.tr(context: context), 
          style: AppTextStyles.regular16,
        ),
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
            'company_management.employees_tab.delete_key_dialog'.tr(context: dialogContext),
            style: AppTextStyles.regular18,
          ),
          actions: [
            CustomButton(
              text: 'company_management.employees_tab.delete_confirm'.tr(context: dialogContext),
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
              'company_management.employees_tab.total'.tr(
                context: context, 
                args: [(employees?.length ?? 0).toString()]
              ),
              style: AppTextStyles.regular22,
            ),
            CustomButton(
              backgroundColor: AppColors.sandyBrown,
              text: 'company_management.employees_tab.add_new'.tr(context: context),
              onPressed: () {
                if (canAddEmployee(departments?.length)) {
                  _onAddEmployeePressed(context, departments!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'company_management.employees_tab.no_departments_error'.tr(context: context),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        Expanded(
          child: RefreshIndicator(
            color: AppColors.sandyBrown,
            onRefresh: () async {
              await context.read<CompanyManagementCubit>().refreshData();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                              'company_management.employees_tab.copy_label'.tr(
                                context: context, 
                                args: [inviteKey!]
                              ),
                              maxLines: 4,
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.gunMetal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _copyInviteKey(context, inviteKey!),
                                icon: Icon(Icons.copy, color: AppColors.gunMetal),
                              ),
                              IconButton(
                                onPressed: () => _showDeleteConfirmationDialog(context),
                                icon: Icon(Icons.close, color: AppColors.tiger),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: gapH10,
                ),
                if (employees != null && employees!.isNotEmpty)
                  SliverList.separated(
                    itemCount: employees!.length,
                    itemBuilder: (context, index) {
                      return EmployeeCard(employee: employees![index]);
                    },
                    separatorBuilder: (context, index) => Divider(height: 12.ph),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}