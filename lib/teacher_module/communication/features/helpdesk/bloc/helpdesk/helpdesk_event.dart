// helpdesk_event.dart
part of 'helpdesk_bloc.dart';

abstract class HelpdeskEvent extends Equatable {
  const HelpdeskEvent();
  @override
  List<Object> get props => [];
}

class LoadHelpdeskData extends HelpdeskEvent {}

class SearchHelpdeskChanged extends HelpdeskEvent {
  final String searchTerm;
  const SearchHelpdeskChanged(this.searchTerm);
  @override
  List<Object> get props => [searchTerm];
}

// Add event if FAQ expansion needs to be tracked in BLoC (usually handled locally)
