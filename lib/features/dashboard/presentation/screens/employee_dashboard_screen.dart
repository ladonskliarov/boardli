import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_icons.dart';
import '../../../chat_assistant/presentation/cubit/chat_assistant_cubit.dart';
import '../../../knowledge_base/presentation/cubit/knowledge_base_cubit.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_bottom_bar_item.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const EmployeeDashboardScreen({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ChatAssistantCubit>()..loadChatHistory()),
        BlocProvider(create: (_) => sl<KnowledgeBaseCubit>()..getResources()),
      ],
      child: Scaffold(
        extendBody: navigationShell.currentIndex != 1,
        backgroundColor: AppColors.gunMetal,
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
      ),
    );
  }
}
