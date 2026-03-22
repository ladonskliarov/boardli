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
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    surfaceTintColor: Colors.transparent,
                    title: Text('Your assistant', style: AppTextStyles.regular28),
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
                      ElevatedButton(
                        onPressed: () {
                          final message = _messageController.text;
                          if (message.isNotEmpty) {
                            context.read<ChatAssistantCubit>().sendMessage(
                              message,
                            );
                            _messageController.clear();
                          }
                        },
                        child: const Text('Send'),
                      ),
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Ask your assistant',
                        ),
                      ),
                      gapH12,
                    ],
                  ),
                );
              } 
              return Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  surfaceTintColor: Colors.transparent,
                  title: Text('Your assistant', style: AppTextStyles.regular28),
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
                      ElevatedButton(
                        onPressed: () {
                          final message = _messageController.text;
                          if (message.isNotEmpty) {
                            context.read<ChatAssistantCubit>().sendMessage(
                              message,
                            );
                            _messageController.clear();
                          }
                        },
                        child: const Text('Send'),
                      ),
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Ask your assistant',
                        ),
                      ),
                      gapH12,
                    ],
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

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: Paddings.paddingVertical20,
        child: message.isLoading
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MarkdownBody(data: message.text),
                ],
              ),
      ),
    );
  }
}