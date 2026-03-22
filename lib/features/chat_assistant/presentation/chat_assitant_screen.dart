import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../core/di/injection_container.dart';
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

class _EmployeeChatAssistantScreenState
    extends State<EmployeeChatAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatAssistantCubit>(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ChatAssistantCubit, ChatState>(
            builder: (context, state) {
              if (state.messages.isEmpty) {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      surfaceTintColor: Colors.transparent,
                      title: Text(
                        'Your assistant',
                        style: AppTextStyles.regular28,
                      ),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text('Ask your assistant anything!'),
                            ),
                          ),
                        ),
                        ChatInputField(
                          chatInputController: _messageController,
                          onSend: () {
                            final message = _messageController.text;
                            if (message.isNotEmpty) {
                              context.read<ChatAssistantCubit>().sendMessage(
                                message,
                              );
                              _messageController.clear();
                            }
                          },
                        ),
                        gapH12,
                      ],
                    ),
                  ),
                );
              }
              return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    surfaceTintColor: Colors.transparent,
                    title: Text(
                      'Your assistant',
                      style: AppTextStyles.regular28,
                    ),
                  ),
                  body: Padding(
                    padding: Paddings.paddingHorizontal20,
                    child: Column(
                      children: [
                        Divider(height: 1, thickness: 1, color: AppColors.grey),
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) =>
                                ChatBubble(message: state.messages[index]),
                          ),
                        ),
                        ChatInputField(
                          chatInputController: _messageController,
                          onSend: () {
                            final message = _messageController.text;
                            if (message.isNotEmpty) {
                              context.read<ChatAssistantCubit>().sendMessage(
                                message,
                              );
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
            },
          );
        },
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.metal,
        borderRadius: .circular(20),
      ),
      margin: Paddings.paddingHorizontal20,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: chatInputController,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: const InputDecoration(
                hintText: 'Type something..',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2),
            child: IconButton(
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {
                if (chatInputController.text.trim().isNotEmpty) {
                  onSend();
                  chatInputController.clear();
                }
              },
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
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: isUser ? Paddings.paddingAll12 : null,
        decoration: isUser
            ? BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              )
            : null,
        margin: Paddings.paddingVertical12,
        child: message.isLoading
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [MarkdownBody(data: message.text)],
              ),
      ),
    );
  }
}
