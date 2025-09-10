import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/leave.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(const LeaveState()) {
    on<LoadLeaves>(_onLoadLeaves);
    on<ApplyLeave>(_onApplyLeave);
    on<ChangeLeaveTab>(_onChangeLeaveTab);
  }

  Future<void> _onLoadLeaves(LoadLeaves event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final leaves = [
        Leave(
          type: "Casual Leave",
          fromDate: DateTime.now().subtract(const Duration(days: 5)),
          toDate: DateTime.now().subtract(const Duration(days: 3)),
          reason: "Family function",
          status: "Approved",
        ),
        Leave(
          type: "Sick Leave",
          fromDate: DateTime.now().subtract(const Duration(days: 2)),
          toDate: DateTime.now().subtract(const Duration(days: 1)),
          reason: "High fever",
          status: "Pending",
        ),
        Leave(
          type: "Paid Leave",
          fromDate: DateTime.now().add(const Duration(days: 5)),
          toDate: DateTime.now().add(const Duration(days: 7)),
          reason: "Vacation",
          status: "Rejected",
        ),
      ];

      emit(state.copyWith(leaves: leaves, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> _onApplyLeave(ApplyLeave event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isSuccess: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void _onChangeLeaveTab(ChangeLeaveTab event, Emitter<LeaveState> emit) {
    emit(
      state.copyWith(
        currentTab: event.tabIndex == 0 ? LeaveTab.overview : LeaveTab.myTicket,
      ),
    );
  }
}
