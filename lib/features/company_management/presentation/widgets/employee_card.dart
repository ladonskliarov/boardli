import 'package:flutter/material.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../../auth/domain/entities/employee_entity.dart';

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
