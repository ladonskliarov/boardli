import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController chatInputController;
  final VoidCallback onSend;

  const ChatInputField({
    required this.chatInputController,
    required this.onSend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkTheme;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.metal : AppColors.white,
        borderRadius: .circular(20),
      ),
      padding: const .only(left: 14, right: 6, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: TextField(
              controller: chatInputController,
              minLines: 1,
              maxLines: 5,
              style: AppTextStyles.regular16.copyWith(
                color: isDark ? AppColors.white : AppColors.gunMetal,
              ),
              decoration: InputDecoration(
                hintText: 'chat_assistant.input_hint'.tr(),
                hintStyle: AppTextStyles.regular16.copyWith(
                  color: isDark
                      ? AppColors.white.withValues(alpha: 0.8)
                      : AppColors.gunMetal.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: Paddings.paddingVertical12,
              ),
            ),
          ),
          Container(
            height: 44,
            width: 44,
            padding: const .only(left: 6, right: 2, top: 4, bottom: 6),
            decoration: BoxDecoration(
              color: isDark ? AppColors.grey : AppColors.softLinen,
              shape: BoxShape.circle,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: .circular(22),
                onTap: onSend,
                child: Transform.rotate(
                  angle: -math.pi / 4,
                  child: const Icon(
                    Icons.send_rounded,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
