part of 'library_details_bloc.dart'; // Link to the BLoC file

// Enum to represent detailed statuses including alert flow
enum LibraryDataStatus {
  initial,
  loading, // General data loading
  success, // General data loaded successfully
  failure, // General data loading failed
  sendingAlert, // Alert API call in progress
  alertSentSuccess, // Alert sent successfully (to show green snackbar)
  alertSentFailure  // Alert sending failed (to show red snackbar)
}

class LibraryDetailsState extends Equatable {
  final LibraryDataStatus status; // Use the detailed enum
  final int selectedTabIndex;
  final String searchQuery;
  // Store all fetched data separately if needed, or refetch on tab change
  final List<LibraryBookItem> allIssuedBooks;
  final List<LibraryBookItem> allReceivedBooks;
  final List<LibraryBookItem> allDueBooks;
  // List currently displayed after filtering
  final List<LibraryBookItem> displayedBooks;
  final int notificationCount;
  final int bottomNavIndex;
  final String? errorMessage; // For general loading errors
  final String? alertErrorMessage; // Specific error message for alert sending failure
  // Holds the book data temporarily while the alert dialog should be visible
  final LibraryBookItem? bookToShowAlertFor;

  const LibraryDetailsState({
    this.status = LibraryDataStatus.initial,
    this.selectedTabIndex = 0,
    this.searchQuery = '',
    this.allIssuedBooks = const [],
    this.allReceivedBooks = const [],
    this.allDueBooks = const [],
    this.displayedBooks = const [],
    this.notificationCount = 3, // Default from image
    this.bottomNavIndex = 0,
    this.errorMessage,
    this.alertErrorMessage,
    this.bookToShowAlertFor,
  });

  // Initial state factory
  factory LibraryDetailsState.initial() {
    // Set default selected tab if needed, otherwise defaults to 0
    return const LibraryDetailsState();
  }

  LibraryDetailsState copyWith({
    LibraryDataStatus? status,
    int? selectedTabIndex,
    String? searchQuery,
    List<LibraryBookItem>? allIssuedBooks,
    List<LibraryBookItem>? allReceivedBooks,
    List<LibraryBookItem>? allDueBooks,
    List<LibraryBookItem>? displayedBooks,
    int? notificationCount,
    int? bottomNavIndex,
    String? errorMessage, bool clearError = false, // Clear general error
    String? alertErrorMessage, bool clearAlertError = false, // Clear alert error
    LibraryBookItem? bookToShowAlertFor, bool clearBookForAlert = false, // Clear dialog trigger
  }) {
    return LibraryDetailsState(
      status: status ?? this.status,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      allIssuedBooks: allIssuedBooks ?? this.allIssuedBooks,
      allReceivedBooks: allReceivedBooks ?? this.allReceivedBooks,
      allDueBooks: allDueBooks ?? this.allDueBooks,
      displayedBooks: displayedBooks ?? this.displayedBooks,
      notificationCount: notificationCount ?? this.notificationCount,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      alertErrorMessage: clearAlertError ? null : alertErrorMessage ?? this.alertErrorMessage,
      bookToShowAlertFor: clearBookForAlert ? null : bookToShowAlertFor ?? this.bookToShowAlertFor,
    );
  }

  @override
  List<Object?> get props => [
    status, selectedTabIndex, searchQuery, allIssuedBooks, allReceivedBooks,
    allDueBooks, displayedBooks, notificationCount, bottomNavIndex, errorMessage,
    alertErrorMessage, bookToShowAlertFor,
  ];
}