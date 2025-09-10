// sms_list_state.dart
part of 'sms_list_bloc.dart';

enum SmsListStatus { initial, loading, success, failure }

class SmsListState extends Equatable {
  final SmsListStatus status;
  final List<SmsConversation> conversations;
  final bool isIncomingTab;
  final Set<String> selectedIds;
  final String searchTerm;
  final String? error;
  // Add dummy data for initial display
  const SmsListState({
    this.status = SmsListStatus.initial,
    this.conversations =
        const [], // Replace with actual dummy data or empty list
    this.isIncomingTab = true,
    this.selectedIds = const {},
    this.searchTerm = '',
    this.error,
  });

  // Example dummy data (replace with actual fetching)
  static List<SmsConversation> get dummyConversations => List.generate(
    5,
    (index) => SmsConversation(
      id: 'id_$index',
      name: 'Anuja Pradhan ${index + 1}',
      lastMessage:
          'The term "Lorem ipsum" comes from atin text by the classical philosopher Cicer',
      timestamp: DateTime.now().subtract(Duration(days: index)),
      unreadCount: index % 3 == 0 ? 2 : 0, // Example unread logic
      avatarInitial: 'A',
    ),
  );

  SmsListState copyWith({
    SmsListStatus? status,
    List<SmsConversation>? conversations,
    bool? isIncomingTab,
    Set<String>? selectedIds,
    String? searchTerm,
    String? error,
  }) {
    return SmsListState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    conversations,
    isIncomingTab,
    selectedIds,
    searchTerm,
    error,
  ];
}

// Placeholder SmsConversation model
class SmsConversation extends Equatable {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final String avatarInitial;

  const SmsConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.avatarInitial,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    lastMessage,
    timestamp,
    unreadCount,
    avatarInitial,
  ];
}
