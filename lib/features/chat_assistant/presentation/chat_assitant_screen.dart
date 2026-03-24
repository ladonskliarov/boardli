import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../core/providers/theme_provider.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_dimensions.dart';
import '../../../core/style/app_text_styles.dart';
import '../data/models/chat_message.dart';
import 'cubit/chat_assistant_cubit.dart';

class EmployeeChatAssistantScreen extends StatefulWidget {
  const EmployeeChatAssistantScreen({super.key});

  @override
  State<EmployeeChatAssistantScreen> createState() =>
      _EmployeeChatAssistantScreenState();
}
class _EmployeeChatAssistantScreenState extends State<EmployeeChatAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        title: Text('chat_assistant.app_bar_title'.tr(), style: AppTextStyles.regular28),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: Paddings.paddingHorizontal20,
          child: Column(
            children: [
              BlocBuilder<ChatAssistantCubit, ChatState>(
                bloc: context.read<ChatAssistantCubit>(),
                builder: (context, state) {
                  if (state is ChatLoadingState) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state.messages.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text('chat_assistant.empty_state'.tr()),
                      ),
                    );
                  } else {
                    final bool isReversed = state.messages.length != 1;
                    return Expanded(
                      child: CustomScrollView(
                        reverse: isReversed,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  ChatBubble(message: state.messages[index]),
                              childCount: state.messages.length,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              ChatInputField(
                chatInputController: _messageController,
                onSend: () {
                  final message = _messageController.text;
                  if (message.isNotEmpty) {
                    context.read<ChatAssistantCubit>().sendMessage(message);
                    _messageController.clear();
                  }
                },
              ),
              gapH12,
            ],
          ),
        ),
      ),
    );
  }
}

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

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Align(
      alignment: isUser ? .centerRight : .centerLeft,
      child: Container(
        padding: isUser ? Paddings.paddingAll12 : null,
        decoration: isUser
            ? BoxDecoration(
                color: context.watch<ThemeProvider>().isDarkTheme
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
