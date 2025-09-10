// create_ticket_state.dart
part of 'create_ticket_bloc.dart';

enum CreateTicketStatus { initial, submitting, success, failure }

class CreateTicketState extends Equatable {
  final CreateTicketStatus status;
  final TicketType selectedType;
  final String comment;
  final String requestId; // Auto-generated or fetched
  final DateTime requestDate; // Current date
  final String? error;

  const CreateTicketState({
    this.status = CreateTicketStatus.initial,
    this.selectedType = TicketType.query, // Default
    this.comment = '',
    required this.requestId,
    required this.requestDate,
    this.error,
  });

  // Helper to generate request ID
  static String _generateRequestId() {
    // Simple example: timestamp based
    return DateTime.now().millisecondsSinceEpoch.toString().substring(3);
  }

  // Factory for initial state
  factory CreateTicketState.initial() {
    return CreateTicketState(
      requestId: _generateRequestId(),
      requestDate: DateTime.now(),
    );
  }

  CreateTicketState copyWith({
    CreateTicketStatus? status,
    TicketType? selectedType,
    String? comment,
    String? requestId,
    DateTime? requestDate,
    String? error,
  }) {
    return CreateTicketState(
      status: status ?? this.status,
      selectedType: selectedType ?? this.selectedType,
      comment: comment ?? this.comment,
      requestId: requestId ?? this.requestId,
      requestDate: requestDate ?? this.requestDate,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedType,
    comment,
    requestId,
    requestDate,
    error,
  ];
}
