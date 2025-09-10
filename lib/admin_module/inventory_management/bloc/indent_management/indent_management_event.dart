import 'package:equatable/equatable.dart';

import '../../data/models/indent_model.dart';

abstract class IndentEvent extends Equatable {
  const IndentEvent();

  @override
  List<Object?> get props => [];
}

// Event to load all indents (initial load or refresh)
class LoadIndents extends IndentEvent {
  final String?
  searchTerm; // Optional: if we want to reload with existing filters
  final String? statusFilter;

  const LoadIndents({this.searchTerm, this.statusFilter});

  @override
  List<Object?> get props => [searchTerm, statusFilter];
}

// Event when the search term changes
class SearchIndents extends IndentEvent {
  final String searchTerm;

  const SearchIndents(this.searchTerm);

  @override
  List<Object?> get props => [searchTerm];
}

// Event when the status filter changes
class FilterIndentsByStatus extends IndentEvent {
  final String status; // e.g., "Pending", "Active", "Inactive", "All"

  const FilterIndentsByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

// Event to add a new indent
class AddIndent extends IndentEvent {
  final IndentModel indent;

  const AddIndent(this.indent);

  @override
  List<Object?> get props => [indent];
}

// You could add events for UpdateIndent and DeleteIndent if needed
// class UpdateIndent extends IndentEvent { ... }
// class DeleteIndent extends IndentEvent { ... }
