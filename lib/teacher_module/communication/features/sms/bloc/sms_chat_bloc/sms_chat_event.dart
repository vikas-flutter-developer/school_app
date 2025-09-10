// sms_chat_event.dart
part of 'sms_chat_bloc.dart';

abstract class SmsChatEvent extends Equatable {
  const SmsChatEvent();
  @override
  List<Object> get props => [];
}

class LoadChatMessages extends SmsChatEvent {
  final String conversationId;
  const LoadChatMessages(this.conversationId);
  @override
  List<Object> get props => [conversationId];
}

class SendChatMessage extends SmsChatEvent {
  final String messageText;
  const SendChatMessage(this.messageText);
  @override
  List<Object> get props => [messageText];
}

class MessageTextChanged extends SmsChatEvent {
  final String text;
  const MessageTextChanged(this.text);
  @override
  List<Object> get props => [text];
}

// Add event for receiving message if using websockets/push
