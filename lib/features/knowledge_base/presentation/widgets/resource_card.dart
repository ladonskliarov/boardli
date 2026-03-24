import 'package:flutter/material.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../data/models/resource.dart';

class ResourceCard extends StatelessWidget {
  final Resource resource;
  const ResourceCard({required this.resource, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Text(
              resource.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regular14,
            ),
          ),
        ],
      ),
    );
  }
}
