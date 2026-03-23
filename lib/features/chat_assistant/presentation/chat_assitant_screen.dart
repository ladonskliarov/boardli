import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
        title: Text('Your assistant', style: AppTextStyles.regular28),
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
              Divider(height: 1, thickness: 1, color: AppColors.grey),
              BlocBuilder<ChatAssistantCubit, ChatState>(
                bloc: context.read<ChatAssistantCubit>(),
                builder: (context, state) {
                  if (state is ChatLoadingState) {
                    return Expanded(child: Center(child: CircularProgressIndicator()));
                  } else if (state.messages.isEmpty) {
                    return Expanded(
                      child: SizedBox(
                        child: Center(
                          child: Text('Ask your assistant anything!'),
                        ),
                      ),
                    );
                  } else if (state.messages.isNotEmpty) {
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
                  } else {
                    return const SizedBox();
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.metal,
        borderRadius: .circular(20),
      ),
      padding: .only(left: 14, right: 6, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: TextField(
              controller: chatInputController,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: const InputDecoration(
                hintText: 'Ask something..',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Container(
            height: 44,
            width: 44,
            padding: .only(left: 6, right: 2, top: 4, bottom: 6),
            decoration: BoxDecoration(
              color: AppColors.grey,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: onSend,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Icon(Icons.send_rounded, color: AppColors.white,)),
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
