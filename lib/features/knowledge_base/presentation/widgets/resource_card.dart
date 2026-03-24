import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../data/models/resource.dart';
import '../cubit/knowledge_base_cubit.dart';

class ResourceCard extends StatelessWidget {
  final Resource resource;
  const ResourceCard({required this.resource, super.key});

  void _showDeleteConfirmationDialog(BuildContext context, String resourceId) {
    final knowledgeBaseCubit = context.read<KnowledgeBaseCubit>();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: knowledgeBaseCubit,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: .circular(20)),
            content: Text(
              'knowledge_base.resources_tab.delete_resource_dialog'.tr(),
              style: AppTextStyles.regular18,
            ),
            actions: [
              CustomButton(
                text: 'knowledge_base.resources_tab.delete_confirm'.tr(),
                onPressed: () {
                  knowledgeBaseCubit.deleteResource(resource.id);
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
          if(sl<AuthCubit>().state is AuthCompanyAuthenticated)
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context, resource.id);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
