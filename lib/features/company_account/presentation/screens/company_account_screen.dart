import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../authorization/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/style/widgets/custom_button.dart';

class CompanyAccountScreen extends StatelessWidget {
  const CompanyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        title: Text('Company Account', style: Theme.of(context).textTheme.headlineMedium),
      ),
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