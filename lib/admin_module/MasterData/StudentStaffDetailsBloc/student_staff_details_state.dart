// bloc/student_staff/student_staff_details_state.dart
part of 'student_staff_details_bloc.dart'; // MUST BE FIRST LINE
enum DataStatus { initial, loading, success, failure }
enum DetailTab { student, staff }

class StudentStaffDetailsState extends Equatable {
  final DataStatus status;
  final DetailTab selectedTab;
  final String generalSearchQuery; // For the top search bar

  // Student Filters & Data
  final String? studentAcademicYear;
  final String? studentTypeStatus;
  final String? studentClass;
  final String? studentFilterOption; // The 'Select by' dropdown
  final String? studentSpecificSearchQuery; // The search bar below 'Select by'
  final List<StudentDetailItem> studentList;
  final int studentCurrentPage;
  final int studentTotalPages;

  // Staff Filters & Data
  final String? staffFilterValue; // The 'Select by' dropdown
  final String? staffSpecificSearchQuery; // The search bar below 'Select by'
  final List<StaffDetailItem> staffList;
  final int staffCurrentPage;
  final int staffTotalPages;

  // Common State
  final int bottomNavIndex;
  final String? errorMessage;

  // Options (Load dynamically or provide defaults)
  final List<String> academicYearOptions;
  final List<String> typeStatusOptions;
  final List<String> classOptions;
  final List<String> studentFilterOptions; // For 'Select by'
  final List<String> staffFilterOptions; // For 'Select by'

  // *** VERIFY CONSTRUCTOR ***
  const StudentStaffDetailsState({
    this.status = DataStatus.initial,
    this.selectedTab = DetailTab.student,
    this.generalSearchQuery = '',
    // Student
    this.studentAcademicYear,
    this.studentTypeStatus,
    this.studentClass,
    this.studentFilterOption,
    this.studentSpecificSearchQuery = '',
    this.studentList = const [],
    this.studentCurrentPage = 1,
    this.studentTotalPages = 1,
    // Staff
    this.staffFilterValue,
    this.staffSpecificSearchQuery = '',
    this.staffList = const [],
    this.staffCurrentPage = 1,
    this.staffTotalPages = 1,
    // Common
    this.bottomNavIndex = 0, // Default to Home
    this.errorMessage,
    // Options - Ensure these have defaults or are required
    this.academicYearOptions = const ['2024-25', '2023-24'],
    this.typeStatusOptions = const ['Type A', 'Type B', 'Active', 'Inactive'],
    this.classOptions = const ['X', 'IX', 'VIII', 'VII'],
    this.studentFilterOptions = const ['Class', 'Student'],
    this.staffFilterOptions = const ['Department', 'Employee ID'],
  });

  // *** VERIFY INITIAL FACTORY ***
  factory StudentStaffDetailsState.initial() {
    // Set initial selections if needed, e.g., matching the first image
    return const StudentStaffDetailsState(
        studentAcademicYear: '2024-25', // Example default from image
        // studentTypeStatus: 'Type A',   // No default clear in V1 image
        // studentClass: 'X',            // No default clear in V1 image
        studentFilterOption: null // No default for V2 'Select by' initially
    );
  }

  // *** VERIFY copyWith *** (Looks okay, but double-check parameter/field names)
  StudentStaffDetailsState copyWith({
    DataStatus? status,
    DetailTab? selectedTab,
    String? generalSearchQuery,
    // Student
    String? studentAcademicYear, bool clearStudentAcademicYear = false,
    String? studentTypeStatus, bool clearStudentTypeStatus = false,
    String? studentClass, bool clearStudentClass = false,
    String? studentFilterOption, bool clearStudentFilterOption = false,
    String? studentSpecificSearchQuery,
    List<StudentDetailItem>? studentList,
    int? studentCurrentPage,
    int? studentTotalPages,
    // Staff
    String? staffFilterValue, bool clearStaffFilterValue = false,
    String? staffSpecificSearchQuery,
    List<StaffDetailItem>? staffList,
    int? staffCurrentPage,
    int? staffTotalPages,
    // Common
    int? bottomNavIndex,
    String? errorMessage, bool clearError = false,
    // Options
    List<String>? academicYearOptions,
    List<String>? typeStatusOptions,
    List<String>? classOptions,
    List<String>? studentFilterOptions,
    List<String>? staffFilterOptions,
  }) {
    return StudentStaffDetailsState(
      status: status ?? this.status,
      selectedTab: selectedTab ?? this.selectedTab,
      generalSearchQuery: generalSearchQuery ?? this.generalSearchQuery,
      studentAcademicYear: clearStudentAcademicYear ? null : studentAcademicYear ?? this.studentAcademicYear,
      studentTypeStatus: clearStudentTypeStatus ? null : studentTypeStatus ?? this.studentTypeStatus,
      studentClass: clearStudentClass ? null : studentClass ?? this.studentClass,
      studentFilterOption: clearStudentFilterOption ? null : studentFilterOption ?? this.studentFilterOption,
      studentSpecificSearchQuery: studentSpecificSearchQuery ?? this.studentSpecificSearchQuery,
      studentList: studentList ?? this.studentList,
      studentCurrentPage: studentCurrentPage ?? this.studentCurrentPage,
      studentTotalPages: studentTotalPages ?? this.studentTotalPages,
      staffFilterValue: clearStaffFilterValue ? null : staffFilterValue ?? this.staffFilterValue,
      staffSpecificSearchQuery: staffSpecificSearchQuery ?? this.staffSpecificSearchQuery,
      staffList: staffList ?? this.staffList,
      staffCurrentPage: staffCurrentPage ?? this.staffCurrentPage,
      staffTotalPages: staffTotalPages ?? this.staffTotalPages,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      academicYearOptions: academicYearOptions ?? this.academicYearOptions,
      typeStatusOptions: typeStatusOptions ?? this.typeStatusOptions,
      classOptions: classOptions ?? this.classOptions,
      studentFilterOptions: studentFilterOptions ?? this.studentFilterOptions,
      staffFilterOptions: staffFilterOptions ?? this.staffFilterOptions,
    );
  }

  // *** VERIFY props *** (Ensure all fields used for state comparison are listed)
  @override
  List<Object?> get props => [
    status, selectedTab, generalSearchQuery,
    studentAcademicYear, studentTypeStatus, studentClass, studentFilterOption, studentSpecificSearchQuery, studentList, studentCurrentPage, studentTotalPages,
    staffFilterValue, staffSpecificSearchQuery, staffList, staffCurrentPage, staffTotalPages,
    bottomNavIndex, errorMessage,
    academicYearOptions, typeStatusOptions, classOptions, studentFilterOptions, staffFilterOptions,
  ];
}