// bloc/feed/feed_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/feed_item.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedState.initial()) { // Initialize with current date
    on<LoadFeedItems>(_onLoadFeedItems);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<BottomNavTapped>(_onBottomNavTapped);

    add(LoadFeedItems()); // Load initially
  }

  Future<void> _onLoadFeedItems(
      LoadFeedItems event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.loading, clearError: true));
    try {
      await Future.delayed(const Duration(milliseconds: 400)); // Simulate loading

      // Use dummy data (replace with actual data fetching)
      var fetchedItems = dummyFeedItems;

      emit(state.copyWith(
        status: FeedStatus.success,
        allFeedItems: fetchedItems,
        // Initially, filtered list is the same as all items
        filteredFeedItems: _filterItems(fetchedItems, state.searchQuery),
      ));
    } catch (e) {
      emit(state.copyWith(status: FeedStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<FeedState> emit) {
    final filtered = _filterItems(state.allFeedItems, event.query);
    // Update both query and filtered list in the state
    emit(state.copyWith(searchQuery: event.query, filteredFeedItems: filtered));
  }

  void _onBottomNavTapped(BottomNavTapped event, Emitter<FeedState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

  // Helper function to filter items based on search query
  List<FeedItem> _filterItems(List<FeedItem> items, String query) {
    if (query.isEmpty) {
      return items;
    }
    final lowerCaseQuery = query.toLowerCase();
    return items.where((item) {
      return item.title.toLowerCase().contains(lowerCaseQuery) ||
          item.description.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }
}