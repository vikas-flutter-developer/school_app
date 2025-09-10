// email_list_state.dart
part of 'email_list_bloc.dart';

enum EmailListStatus { initial, loading, success, failure }

class EmailListState extends Equatable {
  final EmailListStatus status;
  final List<Email> emails;
  final String searchTerm;
  final String? error;

  const EmailListState({
    this.status = EmailListStatus.initial,
    this.emails = const [],
    this.searchTerm = '',
    this.error,
  });

  // Dummy data
  static List<Email> get dummyEmails => List.generate(
    6,
    (index) => Email(
      id: 'email_$index',
      senderInitial: index.isEven ? 'A' : 'J',
      senderName: 'ALorem',
      snippet:
          'The term "Lorem ipsum" comes from atin text by the classical philosopher Cicer',
      timestamp: DateTime.now().subtract(
        Duration(days: index * 2),
      ), // Example timestamp
    ),
  );

  EmailListState copyWith({
    EmailListStatus? status,
    List<Email>? emails,
    String? searchTerm,
    String? error,
  }) {
    return EmailListState(
      status: status ?? this.status,
      emails: emails ?? this.emails,
      searchTerm: searchTerm ?? this.searchTerm,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, emails, searchTerm, error];
}

// Placeholder Email model
class Email extends Equatable {
  final String id;
  final String senderInitial;
  final String senderName;
  final String snippet;
  final DateTime timestamp; // Add timestamp if needed for sorting/display

  const Email({
    required this.id,
    required this.senderInitial,
    required this.senderName,
    required this.snippet,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    senderInitial,
    senderName,
    snippet,
    timestamp,
  ];
}
