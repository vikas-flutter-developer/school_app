// sms_list_event.dart
part of 'sms_list_bloc.dart';

abstract class SmsListEvent extends Equatable {
  const SmsListEvent();
  @override
  List<Object> get props => [];
}

class LoadSmsConversations extends SmsListEvent {
  final bool isIncoming;
  const LoadSmsConversations({required this.isIncoming});
  @override
  List<Object> get props => [isIncoming];
}

class SwitchSmsTab extends SmsListEvent {
  final int tabIndex; // 0 for Incoming, 1 for Outgoing
  const SwitchSmsTab(this.tabIndex);
  @override
  List<Object> get props => [tabIndex];
}

class SearchSmsChanged extends SmsListEvent {
  /* ... */
}

class ToggleSelectAllSms extends SmsListEvent {
  /* ... */
}

class ToggleSelectSmsItem extends SmsListEvent {
  final String conversationId;
  const ToggleSelectSmsItem(this.conversationId);
  @override
  List<Object> get props => [conversationId];
}
