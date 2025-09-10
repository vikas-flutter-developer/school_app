// lib/bloc/library_details/library_details_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Adjust model import path as needed
import '../../models/library_book_item.dart'; // Assuming models are in lib/models/

part 'library_details_event.dart';
part 'library_details_state.dart';

class LibraryDetailsBloc extends Bloc<LibraryDetailsEvent, LibraryDetailsState> {
  // TODO: Inject repository

  // In-memory cache/source of truth (replace with repository calls)
  List<LibraryBookItem> _allIssuedBooks = List.from(dummyIssuedBooks);
  List<LibraryBookItem> _allReceivedBooks = List.from(dummyReceivedBooks);
  List<LibraryBookItem> _allDueBooks = List.from(dummyDueBooks);

  LibraryDetailsBloc(/*{required Repository repo}*/)
      : super(LibraryDetailsState.initial()) {
    // Register event handlers
    on<LoadBooks>(_onLoadBooks);
    on<TabChanged>(_onTabChanged);
    on<SearchChanged>(_onSearchChanged);
    on<BottomNavTapped>(_onBottomNavTapped);
    on<ShowAlertRequest>(_onShowAlertRequest);
    on<SendAlert>(_onSendAlert);
    on<DismissAlertStatus>(_onDismissAlertStatus); // Corrected event name

    // Trigger initial load for the default tab (index 0)
    add(const LoadBooks(0));
  }

  // --- Helper: Get source list based on index ---
  List<LibraryBookItem> _getSourceList(int tabIndex) {
    switch (tabIndex) {
      case 0: return _allIssuedBooks;
      case 1: return _allReceivedBooks;
      case 2: return _allDueBooks;
      default: return [];
    }
  }

  // --- Helper: Filter list based on query ---
  List<LibraryBookItem> _filterList(List<LibraryBookItem> sourceList, String query) {
    if (query.isEmpty) return sourceList;
    final lowerQuery = query.toLowerCase();
    return sourceList.where((book) =>
    book.title.toLowerCase().contains(lowerQuery) ||
        book.subtitle.toLowerCase().contains(lowerQuery) ||
        book.author.toLowerCase().contains(lowerQuery) ||
        book.issuedTo.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  // --- Event Handler Implementations ---

  Future<void> _onLoadBooks(LoadBooks event, Emitter<LibraryDetailsState> emit) async {
    // Always emit loading state when loading starts
    emit(state.copyWith(status: LibraryDataStatus.loading, selectedTabIndex: event.tabIndex, clearError: true, clearAlertError: true));
    try {
      // Simulate API call or fetch from repository based on event.tabIndex
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate network

      // In a real app, update _allIssuedBooks, _allReceivedBooks, _allDueBooks here
      // based on repository response.

      // Get the correct full list for the current tab
      final sourceList = _getSourceList(event.tabIndex);
      // Filter based on the current search query
      final displayed = _filterList(sourceList, state.searchQuery);

      emit(state.copyWith(
        status: LibraryDataStatus.success,
        // Update all lists if they were fetched, otherwise they keep old value
        // allIssuedBooks: fetchedIssued,
        // allReceivedBooks: fetchedReceived,
        // allDueBooks: fetchedDue,
        displayedBooks: displayed,
        // Note: Don't reset searchQuery here, LoadBooks might be triggered by refresh
      ));
    } catch (e) {
      emit(state.copyWith(status: LibraryDataStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onTabChanged(TabChanged event, Emitter<LibraryDetailsState> emit) {
    if (state.selectedTabIndex == event.tabIndex) return;
    // Changing tab means we need to load data for that tab
    add(LoadBooks(event.tabIndex));
    // The state update (selectedTabIndex) happens within _onLoadBooks now
  }

  void _onSearchChanged(SearchChanged event, Emitter<LibraryDetailsState> emit) {
    // Filter the *current* source list based on the new query
    final sourceList = _getSourceList(state.selectedTabIndex);
    final filteredList = _filterList(sourceList, event.query);
    emit(state.copyWith(searchQuery: event.query, displayedBooks: filteredList));
  }

  void _onBottomNavTapped(BottomNavTapped event, Emitter<LibraryDetailsState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

  // Show Alert Dialog Trigger
  void _onShowAlertRequest(ShowAlertRequest event, Emitter<LibraryDetailsState> emit) {
    emit(state.copyWith(bookToShowAlertFor: event.book, clearBookForAlert: false));
    // Reset immediately so listener triggers only once
    emit(state.copyWith(clearBookForAlert: true));
  }

  // Send Alert Action
  Future<void> _onSendAlert(SendAlert event, Emitter<LibraryDetailsState> emit) async {
    emit(state.copyWith(status: LibraryDataStatus.sendingAlert, clearAlertError: true));
    try {
      print("BLoC: Simulating sending alert for '${event.book.title}' - Type: ${event.alertType}");
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      // TODO: Replace with actual API call using an injected repository
      bool success = true; // Assume success

      if (success) {
        print("BLoC: Alert sent successfully.");
        emit(state.copyWith(status: LibraryDataStatus.alertSentSuccess));
      } else {
        print("BLoC: Alert sending failed (API returned false).");
        emit(state.copyWith(status: LibraryDataStatus.alertSentFailure, alertErrorMessage: 'Could not send alert. Please try again.'));
      }
    } catch (e) {
      print("BLoC: Alert sending failed with exception: $e");
      emit(state.copyWith(status: LibraryDataStatus.alertSentFailure, alertErrorMessage: e.toString()));
    }
  }

  // Reset alert status after message shown
  void _onDismissAlertStatus(DismissAlertStatus event, Emitter<LibraryDetailsState> emit) {
    // Only change status if it's currently an alert success/failure state
    if(state.status == LibraryDataStatus.alertSentSuccess || state.status == LibraryDataStatus.alertSentFailure) {
      // Revert to general success state after message dismissal
      emit(state.copyWith(status: LibraryDataStatus.success));
    }
  }
}