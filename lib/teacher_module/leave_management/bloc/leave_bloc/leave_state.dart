part of 'leave_bloc.dart';

enum LeaveTab { overview, myTicket }

class LeaveState extends Equatable {
  final List<Leave> leaves;
  final LeaveTab currentTab;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const LeaveState({
    this.leaves = const [],
    this.currentTab = LeaveTab.overview,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  LeaveState copyWith({
    List<Leave>? leaves,
    LeaveTab? currentTab,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LeaveState(
      leaves: leaves ?? this.leaves,
      currentTab: currentTab ?? this.currentTab,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
    leaves,
    currentTab,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}
