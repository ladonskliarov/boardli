import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../authorization/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../../authorization/presentation/widgets/custom_button.dart';

class CompanyAccountScreen extends StatelessWidget {
  const CompanyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Text('Company Account Screen'),
            gapH12,
            CustomButton(
              text: 'Logout',
              onPressed: () => sl<AuthCubit>().logout(),
            ),
          ],
      ),),
    );
  }
}