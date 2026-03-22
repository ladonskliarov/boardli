import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';

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
        title: Text('Knowledge Base', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: Paddings.paddingHorizontal20,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                gapH10,
                Container(
                  padding: Paddings.paddingHorizontal20,
                  decoration: BoxDecoration(
                    color: AppColors.metal,
                    borderRadius: .circular(40),
                  ),
                  height: 44,
                  child: TabBar(
                    indicatorColor: AppColors.sandyBrown,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    unselectedLabelColor: Colors.grey,
                    labelColor: AppColors.sandyBrown,
                    dividerColor: AppColors.metal,
                    tabs: [
                      Tab(child: Text('Browse')),
                      Tab(child: Text('Upload')),
                    ],
                  ),
                ),
                gapH20,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [BrowseTab(), UploadTab()],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UploadTab extends StatelessWidget {
  const UploadTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
