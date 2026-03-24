import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../data/models/chat_message.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    final isDark = context.watch<ThemeProvider>().isDarkTheme;

    return Align(
      alignment: isUser ? .centerRight : .centerLeft,
      child: Container(
        padding: isUser ? Paddings.paddingAll12 : null,
        decoration: isUser
            ? BoxDecoration(
                color: isDark
                    ? AppColors.grey
                    : AppColors.white,
                borderRadius: .only(
                  topLeft: .circular(20),
                  topRight: .circular(20),
                  bottomLeft: .circular(20),
                ),
              )
            : null,
        margin: Paddings.paddingVertical12,
        child: message.isLoading
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: .start,
                children: [MarkdownBody(data: message.text)],
              ),
      ),
    );
  }
}
