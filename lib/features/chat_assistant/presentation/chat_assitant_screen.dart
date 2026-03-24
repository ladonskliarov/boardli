import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/style/app_dimensions.dart';
import '../../../core/style/app_text_styles.dart';
import 'components/chat_input_field.dart';
import 'cubit/chat_assistant_cubit.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/custom_refresh_button.dart';

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
        title: Row(
          children: [
            Text('chat_assistant.app_bar_title'.tr(), style: AppTextStyles.regular28),
            const Spacer(),
            CustomRefreshButton(
              onRefresh: () async {
                await context.read<ChatAssistantCubit>().refreshChat();
              },
            ),
            gapW4,
          ],
        ),
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
