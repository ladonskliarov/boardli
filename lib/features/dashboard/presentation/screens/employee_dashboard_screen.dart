import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_icons.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_bottom_bar_item.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const EmployeeDashboardScreen({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.softLinen,
      body: navigationShell,
      bottomNavigationBar: CustomBottomBar(
        bottomBarItems: [
          CustomBottomBarItem(
            iconPath: AppIcons.account,
            isSelected: navigationShell.currentIndex == 0,
            onTap: () => navigationShell.goBranch(0),
          ),
          CustomBottomBarItem(
            iconPath: AppIcons.chatAssistant,
            isSelected: navigationShell.currentIndex == 1,
            onTap: () => navigationShell.goBranch(1),
          ),
          CustomBottomBarItem(
            iconPath: AppIcons.upload,
            isSelected: navigationShell.currentIndex == 2,
            onTap: () => navigationShell.goBranch(2),
          ),
        ],
      ),
    );
  }
}
