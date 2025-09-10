// --- Exam Overview State ---
// lib/presentation/blocs/exam_overview/exam_overview_state.dart
part of 'exam_overview_bloc.dart';

enum ExamOverviewStatus { initial, loading, success, failure }

class ExamOverviewState extends Equatable {
  final ExamOverviewStatus status;
  final String selectedClass;
  final String selectedTerm;
  final String? selectedMonth; // Nullable as it might only apply to Timetable
  final String? selectedSubject; // Nullable for "All Subjects"
  final int activeTabIndex; // 0: Plan, 1: Timetable
  final List<ExamPlanItem> examPlanItems;
  final List<ExamTimetableItem> examTimetableItems;
  final String? errorMessage;
  // Available filter options
  final List<String> availableClasses;
  final List<String> availableTerms;
  final List<String> availableSubjects;
  final List<String> availableMonths;

  const ExamOverviewState({
    this.status = ExamOverviewStatus.initial,
    this.selectedClass = 'VII-A', // Default from mockup
    this.selectedTerm = 'Term-I', // Default from mockup
    this.selectedMonth, // Default to null or current month
    this.selectedSubject, // Default to null (all subjects)
    this.activeTabIndex = 1, // Default to Timetable based on mockup
    this.examPlanItems = const [],
    this.examTimetableItems = const [],
    this.errorMessage,
    this.availableClasses = const [
      'VII-A',
      'VIII-A',
      'VIII-B',
      'VIII-C',
    ], // Example
    this.availableTerms = const ['Term-I', 'Term-II'], // Example
    this.availableSubjects = const [
      'All',
      'Science',
      'Mathematics',
      'English',
      'Social Studies',
      'Moral Science',
      'Computer',
    ], // Example
    this.availableMonths = const [
      'All',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ], // Example
  });

  ExamOverviewState copyWith({
    ExamOverviewStatus? status,
    String? selectedClass,
    String? selectedTerm,
    String? selectedMonth, // Use helper to allow setting null
    String? selectedSubject, // Use helper to allow setting null
    int? activeTabIndex,
    List<ExamPlanItem>? examPlanItems,
    List<ExamTimetableItem>? examTimetableItems,
    String? errorMessage,
    List<String>? availableClasses,
    List<String>? availableTerms,
    List<String>? availableSubjects,
    List<String>? availableMonths,
    bool clearError = false,
    bool setMonthToNull = false, // Helper for nullable fields
    bool setSubjectToNull = false, // Helper for nullable fields
  }) {
    return ExamOverviewState(
      status: status ?? this.status,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedTerm: selectedTerm ?? this.selectedTerm,
      selectedMonth:
          setMonthToNull ? null : selectedMonth ?? this.selectedMonth,
      selectedSubject:
          setSubjectToNull ? null : selectedSubject ?? this.selectedSubject,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      examPlanItems: examPlanItems ?? this.examPlanItems,
      examTimetableItems: examTimetableItems ?? this.examTimetableItems,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      availableClasses: availableClasses ?? this.availableClasses,
      availableTerms: availableTerms ?? this.availableTerms,
      availableSubjects: availableSubjects ?? this.availableSubjects,
      availableMonths: availableMonths ?? this.availableMonths,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedClass,
    selectedTerm,
    selectedMonth,
    selectedSubject,
    activeTabIndex,
    examPlanItems,
    examTimetableItems,
    errorMessage,
    availableClasses,
    availableTerms,
    availableSubjects,
    availableMonths,
  ];
}
