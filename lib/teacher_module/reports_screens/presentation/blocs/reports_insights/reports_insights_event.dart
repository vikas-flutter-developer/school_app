// --- Reports & Insights BLoC ---
// lib/presentation/blocs/reports_insights/reports_insights_event.dart
part of 'reports_insights_bloc.dart';

abstract class ReportsInsightsEvent extends Equatable {
  const ReportsInsightsEvent();
  @override
  List<Object?> get props => [];
}

class LoadReportsData extends ReportsInsightsEvent {
  final String classId;
  final String termId; // Add term later if needed for initial load
  const LoadReportsData({required this.classId, required this.termId});
  @override
  List<Object?> get props => [classId, termId];
}

class SelectResultClass extends ReportsInsightsEvent {
  final String selectedClass;
  const SelectResultClass(this.selectedClass);
  @override
  List<Object?> get props => [selectedClass];
}

class SelectResultTerm extends ReportsInsightsEvent {
  final String selectedTerm;
  const SelectResultTerm(this.selectedTerm);
  @override
  List<Object?> get props => [selectedTerm];
}

// Add events for sorting, filtering performance chart if needed
