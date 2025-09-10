part of 'complains_bloc.dart';

class ComplainsState extends Equatable {
  final int selectedTabIndex;
  final List<ComplaintModel> studentComplaints;
  // Add staffComplaints if they differ in the future
  // final List<ComplaintModel> staffComplaints;
  final bool isLoading;

  const ComplainsState({
    this.selectedTabIndex = 0,
    this.studentComplaints = const [],
    // this.staffComplaints = const [],
    this.isLoading = false,
  });

  ComplainsState copyWith({
    int? selectedTabIndex,
    List<ComplaintModel>? studentComplaints,
    // List<ComplaintModel>? staffComplaints,
    bool? isLoading,
  }) {
    return ComplainsState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      studentComplaints: studentComplaints ?? this.studentComplaints,
      // staffComplaints: staffComplaints ?? this.staffComplaints,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [selectedTabIndex, studentComplaints, isLoading];
}
