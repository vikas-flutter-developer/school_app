// sms_chat_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
// Import Repo and Models

part 'sms_chat_event.dart';
part 'sms_chat_state.dart';

class SmsChatBloc extends Bloc<SmsChatEvent, SmsChatState> {
  // final SmsRepository _smsRepository;
  final String conversationId; // Keep track of the current conversation

  SmsChatBloc({required this.conversationId /*, required this.smsRepository*/})
    : super(const SmsChatState()) {
    on<LoadChatMessages>(_onLoadMessages);
    on<SendChatMessage>(_onSendMessage);
    on<MessageTextChanged>(_onMessageTextChanged);

    // Initial load
    add(LoadChatMessages(conversationId));
  }

  Future<void> _onLoadMessages(
    LoadChatMessages event,
    Emitter<SmsChatState> emit,
  ) async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      // final messages = await _smsRepository.getMessages(event.conversationId);
      emit(
        state.copyWith(
          status: ChatStatus.success,
          messages: SmsChatState.dummyMessages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendChatMessage event,
    Emitter<SmsChatState> emit,
  ) async {
    if (event.messageText.trim().isEmpty) return; // Don't send empty messages

    emit(state.copyWith(status: ChatStatus.sending));
    final newMessage = SmsMessage(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}', // Temporary ID
      text: event.messageText.trim(),
      timestamp: DateTime.now(),
      isSender: true, // Assuming message sent by current user
    );

    // Optimistically add message to UI
    final updatedMessages = List<SmsMessage>.from(state.messages)
      ..add(newMessage);
    emit(
      state.copyWith(messages: updatedMessages, currentMessageText: ''),
    ); // Clear input field

    try {
      // Simulate sending
      await Future.delayed(const Duration(milliseconds: 500));
      // final sentMessage = await _smsRepository.sendMessage(conversationId, newMessage.text);

      // Replace temp message with actual message from server if needed (e.g., update ID)
      // Or just confirm success
      emit(
        state.copyWith(status: ChatStatus.success),
      ); // Back to success after sending
    } catch (e) {
      // Handle failed send (e.g., remove optimistic message or show error indicator)
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          error: 'Failed to send message',
          // Optionally remove the message that failed
          messages: state.messages.where((m) => m.id != newMessage.id).toList(),
        ),
      );
    }
  }

  void _onMessageTextChanged(
    MessageTextChanged event,
    Emitter<SmsChatState> emit,
  ) {
    emit(state.copyWith(currentMessageText: event.text));
  }
}
