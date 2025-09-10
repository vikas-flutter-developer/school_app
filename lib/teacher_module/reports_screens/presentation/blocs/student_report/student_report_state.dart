// lib/presentation/blocs/student_report/student_report_state.dart
part of 'student_report_bloc.dart'; // Add this if in a separate file
// lib/presentation/blocs/student_report/student_report_state.dart
// OR add inside student_report_bloc.dart if not using part files

enum StudentReportStatus { initial, loading, success, failure }

class StudentReportState extends Equatable {
  final StudentReportStatus status;
  final Student? studentDetails; // Make nullable for initial/error states
  final String selectedTerm; // Track the currently selected/loaded term
  final List<SubjectResultDetail> subjectResults;
  final dynamic
  studentPerformanceData; // Keep dynamic or define a specific model
  final List<String> availableTerms;
  final String? errorMessage; // Make nullable

  const StudentReportState({
    this.status = StudentReportStatus.initial,
    this.studentDetails,
    this.selectedTerm = '', // Default to empty or initial term if known
    this.subjectResults = const [],
    this.studentPerformanceData,
    this.availableTerms = const [],
    this.errorMessage,
  });

  StudentReportState copyWith({
    StudentReportStatus? status,
    Student? studentDetails,
    String? selectedTerm,
    List<SubjectResultDetail>? subjectResults,
    dynamic studentPerformanceData, // Or specific type
    List<String>? availableTerms,
    String? errorMessage,
    bool clearError = false, // Helper to nullify error message easily
  }) {
    return StudentReportState(
      status: status ?? this.status,
      // Use ??= operator or similar logic if you want to preserve student details
      // during term loading, but the current BLoC logic re-sets it in copyWith,
      // which is fine based on how _onLoadStudentReport is written.
      // For _onSelectStudentTerm, the bloc doesn't pass studentDetails to copyWith,
      // so it correctly retains the existing details.
      studentDetails: studentDetails ?? this.studentDetails,
      selectedTerm: selectedTerm ?? this.selectedTerm,
      subjectResults: subjectResults ?? this.subjectResults,
      studentPerformanceData:
          studentPerformanceData ?? this.studentPerformanceData,
      availableTerms: availableTerms ?? this.availableTerms,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    studentDetails,
    selectedTerm,
    subjectResults,
    studentPerformanceData,
    availableTerms,
    errorMessage,
  ];
}
