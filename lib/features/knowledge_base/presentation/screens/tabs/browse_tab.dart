import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_text_styles.dart';
import '../../../../../core/util/extensions.dart';
import '../../../data/models/resource.dart';
import '../../cubit/knowledge_base_cubit.dart';
import '../../widgets/resource_card.dart';

class BrowseTab extends StatelessWidget {
  final List<Resource> resources;
  const BrowseTab({required this.resources, super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<KnowledgeBaseCubit>().refreshResources();
      },
      color: AppColors.sandyBrown,
      child: resources.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Text(
                      'knowledge_base.browse.empty'.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.light16,
                    ),
                  ),
                ),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: resources.length,
              separatorBuilder: (context, index) => Divider(height: 12.ph),
              itemBuilder: (context, index) {
                final resource = resources[index];
                return ResourceCard(resource: resource);
              },
            ),
    );
  }
}
