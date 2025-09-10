// bloc/student_academics/student_academics_state.dart
part of 'student_academics_bloc.dart';

enum DataStatus { initial, loading, success, failure }

class StudentAcademicsState extends Equatable {
  final DataStatus status;
  final List<Student> students;
  final List<Student> filteredStudents; // Students after applying search/filter
  final String? selectedClass;
  final String? selectedSection;
  final String? selectedAcademicYear;
  final String searchQuery;
  final int bottomNavIndex;
  final String? errorMessage;

  // Add lists for dropdown options
  final List<String> classOptions;
  final List<String> sectionOptions;
  final List<String> academicYearOptions;


  const StudentAcademicsState({
    this.status = DataStatus.initial,
    this.students = const [],
    this.filteredStudents = const [],
    this.selectedClass,
    this.selectedSection,
    this.selectedAcademicYear,
    this.searchQuery = '',
    this.bottomNavIndex = 0, // Default to Home
    this.errorMessage,
    this.classOptions = const ['Class X', 'Class IX', 'Class XI', 'Class XII'], // Example options
    this.sectionOptions = const ['A', 'B', 'C', 'D'], // Example options
    this.academicYearOptions = const ['2024-25', '2023-24', '2022-23'], // Example options
  });

  // Helper to generate the display string like "Class X-A (2024-25)"
  String get currentSelectionDisplay {
    final classStr = selectedClass ?? 'N/A';
    final sectionStr = selectedSection ?? 'N/A';
    final yearStr = selectedAcademicYear != null ? '(${selectedAcademicYear})' : '';
    if (selectedClass == null && selectedSection == null && selectedAcademicYear == null) {
      return 'Select filters above'; // Or some default
    }
    return '$classStr-$sectionStr $yearStr'.replaceAll('N/A-', '').replaceAll('-N/A','');
  }

  StudentAcademicsState copyWith({
    DataStatus? status,
    List<Student>? students,
    List<Student>? filteredStudents,
    String? selectedClass,
    bool clearClass = false, // Flag to explicitly set class to null
    String? selectedSection,
    bool clearSection = false, // Flag to explicitly set section to null
    String? selectedAcademicYear,
    bool clearAcademicYear = false, // Flag to explicitly set year to null
    String? searchQuery,
    int? bottomNavIndex,
    String? errorMessage,
    List<String>? classOptions,
    List<String>? sectionOptions,
    List<String>? academicYearOptions,
  }) {
    return StudentAcademicsState(
      status: status ?? this.status,
      students: students ?? this.students,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      selectedClass: clearClass ? null : selectedClass ?? this.selectedClass,
      selectedSection: clearSection ? null : selectedSection ?? this.selectedSection,
      selectedAcademicYear: clearAcademicYear ? null : selectedAcademicYear ?? this.selectedAcademicYear,
      searchQuery: searchQuery ?? this.searchQuery,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: errorMessage ?? this.errorMessage,
      classOptions: classOptions ?? this.classOptions,
      sectionOptions: sectionOptions ?? this.sectionOptions,
      academicYearOptions: academicYearOptions ?? this.academicYearOptions,
    );
  }

  @override
  List<Object?> get props => [
    status,
    students,
    filteredStudents,
    selectedClass,
    selectedSection,
    selectedAcademicYear,
    searchQuery,
    bottomNavIndex,
    errorMessage,
    classOptions,
    sectionOptions,
    academicYearOptions,
  ];
}