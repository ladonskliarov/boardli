import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/style/app_text_styles.dart';
import '../../../data/models/resource.dart';
import '../../widgets/resource_card.dart';

class BrowseTab extends StatelessWidget {
  final List<Resource> resources;
  const BrowseTab({required this.resources, super.key});

  @override
  Widget build(BuildContext context) {
    if (resources.isEmpty) {
      return Text(
        'knowledge_base.browse.empty'.tr(),
        textAlign: TextAlign.center,
        style: AppTextStyles.light16,
      );
    }
    return ListView.separated(
      itemCount: resources.length,
      separatorBuilder: (context, index) => gapH12,
      itemBuilder: (context, index) {
        final resource = resources[index];
        return ResourceCard(resource: resource);
      },
    );
  }
}