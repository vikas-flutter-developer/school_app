// bloc/student_exam/student_exam_state.dart
part of 'student_exam_bloc.dart';

enum DataStatus { initial, loading, success, failure }

class StudentExamState extends Equatable {
  final DataStatus status;
  final List<ExamSchedule> allExams;
  final List<ExamSchedule> filteredExams; // Exams after search/filter
  final String? selectedClass;
  final String? selectedSection;
  final String? selectedSemester;
  final String? selectedAcademicYear;
  final String searchQuery;
  final int bottomNavIndex;
  final String? errorMessage;

  // Dropdown options (provide sensible defaults or load them)
  final List<String> classOptions;
  final List<String> sectionOptions;
  final List<String> semesterOptions;
  final List<String> academicYearOptions;

  const StudentExamState({
    this.status = DataStatus.initial,
    this.allExams = const [],
    this.filteredExams = const [],
    this.selectedClass,
    this.selectedSection,
    this.selectedSemester,
    this.selectedAcademicYear,
    this.searchQuery = '',
    this.bottomNavIndex = 0, // Default to Home
    this.errorMessage,
    // Example Options - replace with your actual options
    this.classOptions = const ['Class X', 'Class IX', 'Class XI', 'Class XII'],
    this.sectionOptions = const ['A', 'B', 'C', 'D'],
    this.semesterOptions = const ['1st semester', '2nd semester', 'Finals'],
    this.academicYearOptions = const ['2024-25', '2023-24', '2022-23'],
  });

  // Helper to generate the display string like "Class X-A (2024-25) 1st semester exams"
  String get currentSelectionDisplay {
    final classStr = selectedClass ?? '';
    final sectionStr = selectedSection != null ? '-$selectedSection' : '';
    final yearStr = selectedAcademicYear != null ? ' ($selectedAcademicYear)' : '';
    final semesterStr = selectedSemester != null ? ' $selectedSemester exams' : ' exams';

    if (classStr.isEmpty && sectionStr.isEmpty && yearStr.isEmpty && selectedSemester == null) {
      return 'Select filters above'; // Or some default
    }
    // Combine intelligently, handling cases where some filters aren't selected
    String base = '$classStr$sectionStr$yearStr'.trim();
    if (base.isEmpty) base = "All Classes"; // Default if no class/section/year

    return '$base$semesterStr';
  }


  StudentExamState copyWith({
    DataStatus? status,
    List<ExamSchedule>? allExams,
    List<ExamSchedule>? filteredExams,
    String? selectedClass,
    bool clearClass = false,
    String? selectedSection,
    bool clearSection = false,
    String? selectedSemester,
    bool clearSemester = false,
    String? selectedAcademicYear,
    bool clearAcademicYear = false,
    String? searchQuery,
    int? bottomNavIndex,
    String? errorMessage,
    bool clearError = false,
    List<String>? classOptions,
    List<String>? sectionOptions,
    List<String>? semesterOptions,
    List<String>? academicYearOptions,
  }) {
    return StudentExamState(
      status: status ?? this.status,
      allExams: allExams ?? this.allExams,
      filteredExams: filteredExams ?? this.filteredExams,
      selectedClass: clearClass ? null : selectedClass ?? this.selectedClass,
      selectedSection: clearSection ? null : selectedSection ?? this.selectedSection,
      selectedSemester: clearSemester ? null : selectedSemester ?? this.selectedSemester,
      selectedAcademicYear: clearAcademicYear ? null : selectedAcademicYear ?? this.selectedAcademicYear,
      searchQuery: searchQuery ?? this.searchQuery,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      classOptions: classOptions ?? this.classOptions,
      sectionOptions: sectionOptions ?? this.sectionOptions,
      semesterOptions: semesterOptions ?? this.semesterOptions,
      academicYearOptions: academicYearOptions ?? this.academicYearOptions,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allExams,
    filteredExams,
    selectedClass,
    selectedSection,
    selectedSemester,
    selectedAcademicYear,
    searchQuery,
    bottomNavIndex,
    errorMessage,
    classOptions,
    sectionOptions,
    semesterOptions,
    academicYearOptions,
  ];
}