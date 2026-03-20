import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../authorization/presentation/cubits/auth_cubit/auth_cubit.dart';

class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(sl<AuthCubit>().currentCompany.contactName)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc)),
          BottomNavigationBarItem(icon: Icon(Icons.abc)),
          BottomNavigationBarItem(icon: Icon(Icons.abc)),
        ],
      ),
    );
  }
}
