// lib/bloc/issue_item_event.dart
part of 'issue_item_bloc.dart';

abstract class IssueItemEvent extends Equatable {
  const IssueItemEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends IssueItemEvent {
  final int tabIndex;

  const TabChanged(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
