import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../cubit/knowledge_base_cubit.dart';
import 'tabs/browse_tab.dart';
import 'tabs/upload_tab.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({super.key});

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'knowledge_base.title'.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<KnowledgeBaseCubit, KnowledgeBaseState>(
        bloc: context.read<KnowledgeBaseCubit>(),
        builder: (context, state) {
          if (state is KnowledgeBaseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KnowledgeBaseFailure) {
            return Center(child: Text(state.message));
          } else if (state is KnowledgeBaseLoaded) {
            return Padding(
              padding: Paddings.paddingHorizontal20,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  gapH10,
                  Container(
                    padding: Paddings.paddingHorizontal20,
                    decoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().isDarkTheme
                          ? AppColors.metal
                          : AppColors.white,
                      borderRadius: .circular(40),
                    ),
                    height: 44,
                    child: TabBar(
                      indicatorColor: AppColors.sandyBrown,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      unselectedLabelColor:
                          context.watch<ThemeProvider>().isDarkTheme
                          ? AppColors.white.withValues(alpha: 0.6)
                          : AppColors.grey,
                      labelColor: AppColors.sandyBrown,
                      dividerColor: context.watch<ThemeProvider>().isDarkTheme
                          ? AppColors.metal
                          : AppColors.white,
                      tabs: [
                        Tab(child: Text('knowledge_base.tabs.browse'.tr())),
                        Tab(child: Text('knowledge_base.tabs.upload'.tr())),
                      ],
                    ),
                  ),
                  gapH20,
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BrowseTab(resources: state.resources),
                        UploadTab(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
