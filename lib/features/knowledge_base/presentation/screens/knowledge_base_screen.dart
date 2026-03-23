import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/widgets/custom_button.dart';
import '../../../../core/style/widgets/custom_text_field.dart';
import '../../data/models/resource.dart';
import '../cubit/knowledge_base_cubit.dart';

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
          'Knowledge Base',
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
                      color: context.watch<ThemeProvider>().darkTheme
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
                          context.watch<ThemeProvider>().darkTheme
                          ? AppColors.white.withValues(alpha: 0.6)
                          : AppColors.grey,
                      labelColor: AppColors.sandyBrown,
                      dividerColor: context.watch<ThemeProvider>().darkTheme
                          ? AppColors.metal
                          : AppColors.white,
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

class BrowseTab extends StatelessWidget {
  final List<Resource> resources;
  const BrowseTab({required this.resources, super.key});

  @override
  Widget build(BuildContext context) {
    if (resources.isEmpty) {
      return Text(
        'No resources uploaded yet.\nStart sharing knowledge with your team ⚡️',
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Empower your company with a shared knowledge base',
            style: AppTextStyles.light16,
          ),
          gapH20,
          Container(
            padding: Paddings.paddingAll16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().darkTheme
                  ? AppColors.metal
                  : AppColors.white,
              borderRadius: .circular(20),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text('File', style: AppTextStyles.medium20),
                gapH4,
                Text(
                  'Supports: PDF, DOC, DOCX, TXT, md',
                  style: AppTextStyles.light16,
                ),
                gapH12,
                Align(
                  alignment: .bottomRight,
                  child: CustomButton(
                    text: 'Select',
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
          gapH20,
          Container(
            padding: Paddings.paddingAll16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().darkTheme
                  ? AppColors.metal
                  : AppColors.white,
              borderRadius: .circular(20),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text('Link', style: AppTextStyles.medium20),
                gapH12,
                CustomTextField(
                  titleColor: AppColors.white,
                  backgroundColor: context.watch<ThemeProvider>().darkTheme
                      ? AppColors.white
                      : AppColors.platinum,
                  hintText:
                      'https://blog.flutter.dev/whats-new-in-flutter-3-41-302ec140e632',
                  validator: (value) => null,
                  controller: _linkController,
                ),
                gapH8,
                Text('Title (optional)', style: AppTextStyles.medium20),
                gapH12,
                CustomTextField(
                  titleColor: AppColors.white,
                  backgroundColor: context.watch<ThemeProvider>().darkTheme
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
                    text: 'Send',
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
        ],
      ),
    );
  }
}
