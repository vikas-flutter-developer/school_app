// lib/presentation/blocs/reports_insights/reports_insights_state.dart
part of 'reports_insights_bloc.dart';

enum ReportsStatus { initial, loading, success, failure }

class ReportsInsightsState extends Equatable {
  final ReportsStatus status;
  final String selectedClass;
  final String selectedTerm; // For toppers/performance
  final List<StudentResultSummary> studentResults;
  final List<Student> classToppers; // Assuming Student model has rank/photo
  final dynamic classPerformanceData; // Define a specific model later
  final String? errorMessage;
  final List<String> availableClasses; // To populate dropdown
  final List<String> availableTerms; // To populate dropdown

  const ReportsInsightsState({
    this.status = ReportsStatus.initial,
    this.selectedClass = 'VIII-A', // Default or fetch dynamically
    this.selectedTerm = 'Term-I', // Default or fetch dynamically
    this.studentResults = const [],
    this.classToppers = const [],
    this.classPerformanceData,
    this.errorMessage,
    this.availableClasses = const [
      'VIII-A',
      'VIII-B',
      'VIII-C',
      'VII-A',
    ], // Example
    this.availableTerms = const ['Term-I', 'Term-II'], // Example
  });

  ReportsInsightsState copyWith({
    ReportsStatus? status,
    String? selectedClass,
    String? selectedTerm,
    List<StudentResultSummary>? studentResults,
    List<Student>? classToppers,
    dynamic classPerformanceData, // Use specific type
    String? errorMessage,
    List<String>? availableClasses,
    List<String>? availableTerms,
  }) {
    return ReportsInsightsState(
      status: status ?? this.status,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedTerm: selectedTerm ?? this.selectedTerm,
      studentResults: studentResults ?? this.studentResults,
      classToppers: classToppers ?? this.classToppers,
      classPerformanceData: classPerformanceData ?? this.classPerformanceData,
      errorMessage: errorMessage ?? this.errorMessage,
      availableClasses: availableClasses ?? this.availableClasses,
      availableTerms: availableTerms ?? this.availableTerms,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedClass,
    selectedTerm,
    studentResults,
    classToppers,
    classPerformanceData,
    errorMessage,
    availableClasses,
    availableTerms,
  ];
}
