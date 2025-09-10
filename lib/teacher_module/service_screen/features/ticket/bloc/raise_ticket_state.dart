part of 'raise_ticket_cubit.dart';

abstract class RaiseTicketState extends Equatable {
  const RaiseTicketState();

  @override
  List<Object?> get props => [];
}

class RaiseTicketInitial extends RaiseTicketState {}

class RaiseTicketSubmitting extends RaiseTicketState {}

class RaiseTicketSuccess extends RaiseTicketState {}

class RaiseTicketFailure extends RaiseTicketState {
  final String message;

  const RaiseTicketFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Optional: If you need to manage form field values in state
class RaiseTicketFormState extends RaiseTicketState {
  final String? selectedCategory;
  final DateTime? selectedDate;
  // Add other fields if needed

  const RaiseTicketFormState({this.selectedCategory, this.selectedDate});

  RaiseTicketFormState copyWith({
    String? selectedCategory,
    DateTime? selectedDate,
  }) {
    return RaiseTicketFormState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [selectedCategory, selectedDate];
}
