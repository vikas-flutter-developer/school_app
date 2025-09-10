// bloc/feed/feed_state.dart
part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, success, failure }

class FeedState extends Equatable {
  final FeedStatus status;
  final List<FeedItem> allFeedItems;
  final List<FeedItem> filteredFeedItems; // For search results
  final String searchQuery;
  final int bottomNavIndex;
  final String? errorMessage;
  final DateTime currentDate; // Store current date

  const FeedState({
    this.status = FeedStatus.initial,
    this.allFeedItems = const [],
    this.filteredFeedItems = const [],
    this.searchQuery = '',
    this.bottomNavIndex = 1, // Default to Feed selected
    this.errorMessage,
    required this.currentDate,
  });

  // Initialize with current date
  factory FeedState.initial() => FeedState(currentDate: DateTime.now());

  FeedState copyWith({
    FeedStatus? status,
    List<FeedItem>? allFeedItems,
    List<FeedItem>? filteredFeedItems,
    String? searchQuery,
    int? bottomNavIndex,
    String? errorMessage,
    bool clearError = false,
    DateTime? currentDate,
  }) {
    return FeedState(
      status: status ?? this.status,
      allFeedItems: allFeedItems ?? this.allFeedItems,
      filteredFeedItems: filteredFeedItems ?? this.filteredFeedItems,
      searchQuery: searchQuery ?? this.searchQuery,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      currentDate: currentDate ?? this.currentDate,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allFeedItems,
    filteredFeedItems,
    searchQuery,
    bottomNavIndex,
    errorMessage,
    currentDate,
  ];
}