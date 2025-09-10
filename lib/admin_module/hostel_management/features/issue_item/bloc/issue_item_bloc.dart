// lib/bloc/issue_item_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issue_item_event.dart';
part 'issue_item_state.dart';

class IssueItemBloc extends Bloc<IssueItemEvent, IssueItemState> {
  IssueItemBloc() : super(const IssueItemState()) {
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(TabChanged event, Emitter<IssueItemState> emit) {
    emit(state.copyWith(selectedTabIndex: event.tabIndex));
  }
}
