// sms_list_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// For date formatting
// Import Repo and Models

part 'sms_list_event.dart';
part 'sms_list_state.dart';

class SmsListBloc extends Bloc<SmsListEvent, SmsListState> {
  // final SmsRepository _smsRepository;

  SmsListBloc(/*required this.smsRepository*/)
    : super(SmsListState(conversations: SmsListState.dummyConversations)) {
    // Initial dummy data
    on<LoadSmsConversations>(_onLoadConversations);
    on<SwitchSmsTab>(_onSwitchTab);
    on<ToggleSelectSmsItem>(_onToggleSelectItem);
    // Add handlers for Search, SelectAll
  }

  Future<void> _onLoadConversations(
    LoadSmsConversations event,
    Emitter<SmsListState> emit,
  ) async {
    emit(state.copyWith(status: SmsListStatus.loading));
    try {
      // final conversations = await _smsRepository.getConversations(isIncoming: event.isIncoming);
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      // Use dummy data for now
      final conversations =
          event.isIncoming
              ? SmsListState.dummyConversations
              : SmsListState.dummyConversations.reversed
                  .toList(); // Different list for outgoing example

      emit(
        state.copyWith(
          status: SmsListStatus.success,
          conversations: conversations,
          isIncomingTab: event.isIncoming,
          selectedIds: {}, // Clear selection on load
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: SmsListStatus.failure, error: e.toString()));
    }
  }

  void _onSwitchTab(SwitchSmsTab event, Emitter<SmsListState> emit) {
    final bool isIncoming = event.tabIndex == 0;
    if (state.isIncomingTab != isIncoming) {
      // Trigger load for the new tab
      add(LoadSmsConversations(isIncoming: isIncoming));
    }
  }

  void _onToggleSelectItem(
    ToggleSelectSmsItem event,
    Emitter<SmsListState> emit,
  ) {
    final currentSelection = Set<String>.from(state.selectedIds);
    if (currentSelection.contains(event.conversationId)) {
      currentSelection.remove(event.conversationId);
    } else {
      currentSelection.add(event.conversationId);
    }
    emit(state.copyWith(selectedIds: currentSelection));
  }

  // Implement other handlers...
}
