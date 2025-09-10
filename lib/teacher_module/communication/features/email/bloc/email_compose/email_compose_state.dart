// email_compose_state.dart
part of 'email_compose_bloc.dart';

enum EmailComposeStatus { initial, loading, ready, sending, success, failure }

// Define recipient groups
class RecipientGroup extends Equatable {
  final String id;
  final String name;
  final bool isPredefined; // e.g., All Parents vs custom lists

  const RecipientGroup({
    required this.id,
    required this.name,
    this.isPredefined = true,
  });

  @override
  List<Object> get props => [id, name, isPredefined];

  // Dummy data for recipient groups
  static List<RecipientGroup> get dummyGroups => const [
    RecipientGroup(id: 'all_parents', name: 'All Parents'),
    RecipientGroup(id: 'all_staff', name: 'All Staff'),
    RecipientGroup(id: 'all_admissions', name: 'All Admissions'),
    RecipientGroup(id: 'class_list', name: 'Class List'),
    RecipientGroup(id: 'parent_list', name: 'Parent list'),
    RecipientGroup(id: 'vendors_transport', name: 'Vendors & Transport Team'),
  ];
}

class EmailComposeState extends Equatable {
  final EmailComposeStatus status;
  final List<String> fromOptions; // List of possible sender emails/names
  final String? selectedFrom;
  final List<RecipientGroup> availableRecipientGroups;
  final Set<String> selectedRecipientGroupIds;
  final String subject;
  final String body;
  final String? error;

  const EmailComposeState({
    this.status = EmailComposeStatus.initial,
    this.fromOptions = const [],
    this.selectedFrom,
    this.availableRecipientGroups = const [],
    this.selectedRecipientGroupIds = const {},
    this.subject = '',
    this.body = '',
    this.error,
  });

  EmailComposeState copyWith({
    EmailComposeStatus? status,
    List<String>? fromOptions,
    String? selectedFrom,
    List<RecipientGroup>? availableRecipientGroups,
    Set<String>? selectedRecipientGroupIds,
    String? subject,
    String? body,
    String? error,
  }) {
    return EmailComposeState(
      status: status ?? this.status,
      fromOptions: fromOptions ?? this.fromOptions,
      selectedFrom: selectedFrom ?? this.selectedFrom,
      availableRecipientGroups:
          availableRecipientGroups ?? this.availableRecipientGroups,
      selectedRecipientGroupIds:
          selectedRecipientGroupIds ?? this.selectedRecipientGroupIds,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    fromOptions,
    selectedFrom,
    availableRecipientGroups,
    selectedRecipientGroupIds,
    subject,
    body,
    error,
  ];
}
