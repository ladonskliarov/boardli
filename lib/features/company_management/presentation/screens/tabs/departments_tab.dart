import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/style/app_text_styles.dart';
import '../../../../../core/style/widgets/custom_button.dart';
import '../../components/add_department_form.dart';
import '../../cubit/company_management_cubit.dart';
import '../../widgets/department_card.dart';

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
