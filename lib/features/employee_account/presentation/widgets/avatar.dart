import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  const AvatarWidget({required this.avatarUrl, super.key});

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
        return Container(
          width: 144,
          height: 144,
          padding: .all(6),
          decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().isDarkTheme
                ? AppColors.white
                : AppColors.grey,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl!,
              fit: .cover,
              placeholder: (context, url) => Container(
                color: AppColors.white,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.sandyBrown),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.grey,
                child: const Center(
                  child: Icon(Icons.person, color: AppColors.white),
                ),
              ),
            ),
          ),
        );
    }
    return CircleAvatar(
      radius: 72,
      backgroundColor: AppColors.grey,
      child: Icon(Icons.person, color: AppColors.white),
    );
  }
}
