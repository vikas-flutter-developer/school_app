import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../widgets/message_bubble.dart';
import '../bloc/sms_chat_bloc/sms_chat_bloc.dart';

class SmsChatScreen extends StatefulWidget {
  final String conversationId;
  final String contactName;
  final String avatarInitial;

  const SmsChatScreen({
    Key? key,
    required this.conversationId,
    required this.contactName,
    required this.avatarInitial,
  }) : super(key: key);

  @override
  State<SmsChatScreen> createState() => _SmsChatScreenState();
}

class _SmsChatScreenState extends State<SmsChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmsChatBloc(conversationId: widget.conversationId),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: ScreenUtilHelper.scaleWidth(24)),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: ScreenUtilHelper.scaleWidth(18),
                backgroundColor: AppColors.cloud,
                child: Text(
                  widget.avatarInitial,
                  style: TextStyle(
                    fontWeight: AppStyles.weight.heading,
                    color: AppColors.black,
                    fontSize: ScreenUtilHelper.scaleText(16),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              Text(
                widget.contactName,
                style: TextStyle(fontSize: ScreenUtilHelper.scaleText(16)),
              ),
            ],
          ),
          backgroundColor: AppColors.linen,
          foregroundColor: AppColors.black,
          elevation: 1,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<SmsChatBloc, SmsChatState>(
                listener: (context, state) {
                  if (state.status == ChatStatus.success || state.status == ChatStatus.sending) {
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  if (state.status == ChatStatus.loading && state.messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == ChatStatus.failure && state.messages.isEmpty) {
                    return Center(
                      child: Text('Error loading messages: ${state.error}'),
                    );
                  }
                  if (state.messages.isEmpty) {
                    return const Center(child: Text('No messages yet.'));
                  }

                  Map<String, List<SmsMessage>> groupedMessages = {};
                  final DateFormat headerFormat = DateFormat('EEEE, MMM d');

                  for (var message in state.messages) {
                    String dateKey = headerFormat.format(message.timestamp.toLocal());
                    groupedMessages.putIfAbsent(dateKey, () => []).add(message);
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                    itemCount: groupedMessages.length,
                    itemBuilder: (context, index) {
                      String dateKey = groupedMessages.keys.elementAt(index);
                      List<SmsMessage> messagesForDate = groupedMessages[dateKey]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtilHelper.scaleHeight(16),
                            ),
                            child: Text(
                              dateKey,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.stone,
                                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                              ),
                            ),
                          ),
                          ...messagesForDate
                              .map((message) => MessageBubble(message: message))
                              .toList(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Divider(height: ScreenUtilHelper.scaleHeight(1)),
            _buildMessageInput(context),
          ],
        ),
        backgroundColor: AppColors.white,
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return BlocBuilder<SmsChatBloc, SmsChatState>(
      builder: (context, state) {
        if (state.currentMessageText.isEmpty && _textController.text.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _textController.clear();
          });
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(8),
            vertical: ScreenUtilHelper.scaleHeight(8),
          ),
          color: AppColors.linen,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  onChanged: (text) => context.read<SmsChatBloc>().add(MessageTextChanged(text)),
                  decoration: InputDecoration(
                    hintText: 'Text Message',
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(20)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(16),
                      vertical: ScreenUtilHelper.scaleHeight(10),
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 5,
                  style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              IconButton(
                icon: Icon(Icons.mic_none_outlined,
                    size: ScreenUtilHelper.scaleWidth(22),
                    color: AppColors.stone),
                onPressed: () {
                  // Handle mic tap
                },
              ),
              IconButton(
                icon: Icon(Icons.send,
                    size: ScreenUtilHelper.scaleWidth(24),
                    color: Theme.of(context).primaryColor),
                onPressed: state.currentMessageText.trim().isEmpty ||
                    state.status == ChatStatus.sending
                    ? null
                    : () {
                  context
                      .read<SmsChatBloc>()
                      .add(SendChatMessage(state.currentMessageText));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
