part of 'staff_form_bloc.dart';

enum StaffFormStatus { initial, loading, success, error, editing }

class StaffFormState {
  final StaffFormStatus status;
  final StaffMember
  staffMember; // Holds current form data, initialized from existing or default
  final String? errorMessage;
  // Store original staff member if editing, to compare changes or revert
  final StaffMember? originalStaffMember;

  // Explicit fields for text controllers might be more robust for complex forms
  // but for direct mapping from UI to state, this works.
  // Keeping it simple by having StaffMember object manage all data.

  const StaffFormState({
    this.status = StaffFormStatus.initial,
    required this.staffMember,
    this.originalStaffMember,
    this.errorMessage,
  });

  factory StaffFormState.initial() {
    return StaffFormState(
      status: StaffFormStatus.initial,
      staffMember: StaffMember.empty(), // Start with an empty staff member
    );
  }

  StaffFormState copyWith({
    StaffFormStatus? status,
    StaffMember? staffMember,
    StaffMember? originalStaffMember,
    String? errorMessage,
  }) {
    return StaffFormState(
      status: status ?? this.status,
      staffMember: staffMember ?? this.staffMember,
      originalStaffMember: originalStaffMember ?? this.originalStaffMember,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
