// sms_chat_state.dart
part of 'sms_chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure, sending }

class SmsChatState extends Equatable {
  final ChatStatus status;
  final List<SmsMessage> messages;
  final String currentMessageText;
  final String? error;
  // Add dummy data
  const SmsChatState({
    this.status = ChatStatus.initial,
    this.messages = const [], // Replace with actual dummy data
    this.currentMessageText = '',
    this.error,
  });

  // Example dummy messages
  static List<SmsMessage> get dummyMessages => [
    SmsMessage(
      id: 'm1',
      text:
          'The term "Lorem ipsum" comes from sections of a Latin text by the classical philosopher Cicero, specifically his work "De finibus bonorum et malorum" (On the Ends of Goods and Ev',
      timestamp: DateTime.now().subtract(Duration(days: 3, hours: 2)),
      isSender: false,
    ),
    SmsMessage(
      id: 'm2',
      text:
          'The term "Lorem ipsum" comes from sections of a Latin text by the classical philosopher Cicero, specifically his work "De finibus bonorum et malorum" (On the Ends of Goods and Ev',
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
      isSender: false,
    ),
    SmsMessage(
      id: 'm3',
      text:
          'The term "Lorem ipsum" comes from sections of a Latin text by the classical philosopher Cicero, specifically his work "De finibus bonorum et malorum" (On the Ends of Goods and Ev',
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      isSender: false,
    ),
  ];

  SmsChatState copyWith({
    ChatStatus? status,
    List<SmsMessage>? messages,
    String? currentMessageText,
    String? error,
  }) {
    return SmsChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      currentMessageText: currentMessageText ?? this.currentMessageText,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, messages, currentMessageText, error];
}

// Placeholder SmsMessage model
class SmsMessage extends Equatable {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isSender; // true if the current user sent it

  const SmsMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isSender,
  });

  @override
  List<Object?> get props => [id, text, timestamp, isSender];
}
