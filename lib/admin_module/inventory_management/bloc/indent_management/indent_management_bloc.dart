import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

import '../../data/models/indent_model.dart';
import '../../data/repo/inventory_repository.dart';
import 'indent_management_event.dart';
import 'indent_management_state.dart'; // For debounce if needed

class IndentBloc extends Bloc<IndentEvent, IndentState> {
  final InventoryRepository inventoryRepository;
  // Timer? _debounce; // For debouncing search

  IndentBloc({required this.inventoryRepository}) : super(const IndentState()) {
    on<LoadIndents>(_onLoadIndents);
    on<SearchIndents>(_onSearchIndents);
    on<FilterIndentsByStatus>(_onFilterIndentsByStatus);
    on<AddIndent>(_onAddIndent);
  }

  Future<void> _onLoadIndents(
    LoadIndents event,
    Emitter<IndentState> emit,
  ) async {
    emit(
      state.copyWith(
        status: IndentStatusState.loading,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
    try {
      // Fetch all indents from the repository
      // The repository's getIndents method should handle internal filtering if searchTerm/statusFilter are passed
      // For simplicity here, we fetch all and then filter, but for performance, repo should filter.
      final allIndents = await inventoryRepository.getIndents(
        // If your repo supports server-side filtering, pass these:
        // searchTerm: event.searchTerm ?? state.searchTerm,
        // statusFilter: event.statusFilter ?? state.statusFilter,
      );
      emit(
        state.copyWith(
          allIndents: allIndents,
          // Apply current filters to the newly fetched list
          // This will be handled by _applyFiltersAndEmit
        ),
      );
      // After loading, apply existing filters
      _applyFiltersAndEmit(
        emit,
        searchTerm: state.searchTerm,
        statusFilter: state.statusFilter,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: IndentStatusState.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // Handles applying both search and status filters
  void _applyFiltersAndEmit(
    Emitter<IndentState> emit, {
    String? searchTerm,
    String? statusFilter,
  }) {
    List<IndentModel> filteredIndents = List.from(state.allIndents);

    // Apply search term filter
    final currentSearchTerm = searchTerm ?? state.searchTerm;
    if (currentSearchTerm != null && currentSearchTerm.isNotEmpty) {
      filteredIndents =
          filteredIndents.where((indent) {
            final term = currentSearchTerm.toLowerCase();
            return indent.indentNo.toLowerCase().contains(term) ||
                indent.title.toLowerCase().contains(term) ||
                indent.raisedBy.toLowerCase().contains(term) ||
                indent.date.toString().toLowerCase().contains(
                  term,
                ); // Basic date search
          }).toList();
    }

    // Apply status filter
    final currentStatusFilter = statusFilter ?? state.statusFilter ?? 'All';
    if (currentStatusFilter != 'All') {
      IndentStatus filterEnum;
      switch (currentStatusFilter.toLowerCase()) {
        case "pending":
          filterEnum = IndentStatus.pending;
          break;
        case "active":
          filterEnum = IndentStatus.active;
          break;
        case "inactive":
          filterEnum = IndentStatus.inactive;
          break;
        default:
          // If filter is not recognized, effectively show all for this part
          // or handle error. For now, we assume valid filter strings.
          emit(
            state.copyWith(
              status: IndentStatusState.success,
              indents: filteredIndents, // Indents filtered only by search
              searchTerm: currentSearchTerm,
              statusFilter: currentStatusFilter,
            ),
          );
          return;
      }
      filteredIndents =
          filteredIndents
              .where((indent) => indent.status == filterEnum)
              .toList();
    }

    emit(
      state.copyWith(
        status: IndentStatusState.success,
        indents: filteredIndents,
        searchTerm: currentSearchTerm, // Update state with current search term
        statusFilter:
            currentStatusFilter, // Update state with current status filter
      ),
    );
  }

  void _onSearchIndents(SearchIndents event, Emitter<IndentState> emit) {
    // Debounce logic (optional, good for performance if search triggers API calls)
    // if (_debounce?.isActive ?? false) _debounce!.cancel();
    // _debounce = Timer(const Duration(milliseconds: 300), () {
    //   _applyFiltersAndEmit(emit, searchTerm: event.searchTerm);
    // });
    _applyFiltersAndEmit(
      emit,
      searchTerm: event.searchTerm,
      statusFilter: state.statusFilter,
    );
  }

  void _onFilterIndentsByStatus(
    FilterIndentsByStatus event,
    Emitter<IndentState> emit,
  ) {
    _applyFiltersAndEmit(
      emit,
      searchTerm: state.searchTerm,
      statusFilter: event.status,
    );
  }

  Future<void> _onAddIndent(AddIndent event, Emitter<IndentState> emit) async {
    emit(
      state.copyWith(
        status: IndentStatusState.submitting,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
    try {
      // Create a new IndentModel, potentially generating some fields here or in repo
      // For example, if srNo and indentNo are generated server-side, they might be empty initially
      // The repository's addIndent should handle saving it.
      await inventoryRepository.addIndent(event.indent);

      // After adding, reload the list to see the new indent
      // Or, if addIndent returns the created indent, add it to state.allIndents locally.
      // For simplicity and to ensure fresh data, we reload.
      final updatedAllIndents = await inventoryRepository.getIndents();
      emit(
        state.copyWith(
          allIndents: updatedAllIndents,
          successMessage: 'Indent added successfully!',
        ),
      );
      _applyFiltersAndEmit(
        emit,
        searchTerm: state.searchTerm,
        statusFilter: state.statusFilter,
      ); // Re-apply filters
    } catch (e) {
      emit(
        state.copyWith(
          status: IndentStatusState.failure,
          errorMessage: 'Failed to add indent: ${e.toString()}',
        ),
      );
    }
  }

  // @override
  // Future<void> close() {
  //   _debounce?.cancel();
  //   return super.close();
  // }
}
