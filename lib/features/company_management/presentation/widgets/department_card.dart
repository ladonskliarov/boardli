import 'package:flutter/material.dart';

import '../../../../core/style/app_text_styles.dart';

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