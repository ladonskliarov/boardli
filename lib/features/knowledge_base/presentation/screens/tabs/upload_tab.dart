
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/providers/theme_provider.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/style/app_text_styles.dart';
import '../../../../../core/style/widgets/custom_button.dart';
import '../../../../../core/style/widgets/custom_text_field.dart';
import '../../cubit/knowledge_base_cubit.dart';

class UploadTab extends StatefulWidget {
  const UploadTab({super.key});

  @override
  State<UploadTab> createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _linkController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'knowledge_base.upload.promo_text'.tr(),
          style: AppTextStyles.light16,
        ),
        gapH20,
        Container(
          padding: Paddings.paddingAll16,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().isDarkTheme
                ? AppColors.metal
                : AppColors.white,
            borderRadius: .circular(20),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('knowledge_base.upload.file_section.title'.tr(), style: AppTextStyles.medium20),
              gapH4,
              Text(
                'knowledge_base.upload.file_section.supports'.tr(),
                style: AppTextStyles.light16,
              ),
              gapH6,
              Align(
                alignment: .bottomRight,
                child: CustomButton(
                  text: 'knowledge_base.upload.file_section.select_button'.tr(),
                  backgroundColor: AppColors.sandyBrown,
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: [
                            'pdf',
                            'doc',
                            'docx',
                            'txt',
                            'md',
                          ],
                        );
                    if (result != null) {
                      if (context.mounted) {
                        context.read<KnowledgeBaseCubit>().uploadFile(
                          File(result.files.single.path!),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        gapH10,
        Container(
          padding: Paddings.paddingAll16,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().isDarkTheme
                ? AppColors.metal
                : AppColors.white,
            borderRadius: .circular(20),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('knowledge_base.upload.link_section.title'.tr(), style: AppTextStyles.medium20),
              gapH12,
              CustomTextField(
                titleColor: AppColors.white,
                backgroundColor: context.watch<ThemeProvider>().isDarkTheme
                    ? AppColors.white
                    : AppColors.platinum,
                hintText:
                    'https://blog.flutter.dev/whats-new-in-flutter-3-41-302ec140e632',
                validator: (value) => null,
                controller: _linkController,
              ),
              gapH8,
              Text('knowledge_base.upload.link_section.optional_title'.tr(), style: AppTextStyles.medium20),
              gapH12,
              CustomTextField(
                titleColor: AppColors.white,
                backgroundColor: context.watch<ThemeProvider>().isDarkTheme
                    ? AppColors.white
                    : AppColors.platinum,
                hintText: 'Flutter Update 3.41',
                validator: (value) => null,
                controller: _titleController,
              ),
              gapH12,
              Align(
                alignment: .bottomRight,
                child: CustomButton(
                  text: 'knowledge_base.upload.link_section.send_button'.tr(),
                  backgroundColor: AppColors.sandyBrown,
                  onPressed: () {
                    context.read<KnowledgeBaseCubit>().uploadLink(
                      link: _linkController.text,
                      title: _titleController.text.isEmpty
                          ? null
                          : _titleController.text,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        gapH20,
      ],
    );
  }
}
