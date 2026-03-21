import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../authorization/presentation/cubits/auth_cubit/auth_cubit.dart';

class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(sl<AuthCubit>().currentCompany.contactName),
          ElevatedButton(onPressed: context.read<ThemeProvider>().switchDarkTheme, child: Text('Change theme'),),
          ElevatedButton(onPressed: sl<AuthCubit>().logout, child: Text('Logout'),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Tab 1'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Tab 2'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Tab 3'),
        ],
      ),
    );
  }
}
