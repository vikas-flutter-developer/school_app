import 'package:equatable/equatable.dart';

import '../../data/models/indent_model.dart';

enum IndentStatusState {
  initial,
  loading,
  success,
  failure,
  submitting,
} // Added submitting for add operation

class IndentState extends Equatable {
  final IndentStatusState status;
  final List<IndentModel> indents; // The currently displayed list of indents
  final List<IndentModel> allIndents; // The master list fetched from repository
  final String? searchTerm;
  final String? statusFilter; // e.g., "Pending", "Active", "All"
  final String? errorMessage;
  final String? successMessage; // For successful operations like adding

  const IndentState({
    this.status = IndentStatusState.initial,
    this.indents = const [],
    this.allIndents = const [],
    this.searchTerm,
    this.statusFilter = 'All', // Default to show all
    this.errorMessage,
    this.successMessage,
  });

  IndentState copyWith({
    IndentStatusState? status,
    List<IndentModel>? indents,
    List<IndentModel>? allIndents,
    String? searchTerm,
    String? statusFilter,
    String? errorMessage,
    String? successMessage,
    bool clearErrorMessage = false, // Utility to clear error message
    bool clearSuccessMessage = false, // Utility to clear success message
  }) {
    return IndentState(
      status: status ?? this.status,
      indents: indents ?? this.indents,
      allIndents: allIndents ?? this.allIndents,
      searchTerm: searchTerm ?? this.searchTerm,
      statusFilter: statusFilter ?? this.statusFilter,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    indents,
    allIndents,
    searchTerm,
    statusFilter,
    errorMessage,
    successMessage,
  ];
}
