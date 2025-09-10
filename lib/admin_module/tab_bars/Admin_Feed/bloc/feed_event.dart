// bloc/feed/feed_event.dart (Create folder and file)
part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
  @override List<Object?> get props => [];
}

class LoadFeedItems extends FeedEvent {}

class SearchQueryChanged extends FeedEvent {
  final String query;
  const SearchQueryChanged(this.query);
  @override List<Object?> get props => [query];
}

class BottomNavTapped extends FeedEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override List<Object?> get props => [index];
}