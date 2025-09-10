// lib/bloc/issue_item_state.dart
part of 'issue_item_bloc.dart';

class IssueItemState extends Equatable {
  final int selectedTabIndex;

  const IssueItemState({this.selectedTabIndex = 2}); // Default to 'Others' tab

  IssueItemState copyWith({int? selectedTabIndex}) {
    return IssueItemState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object> get props => [selectedTabIndex];
}
