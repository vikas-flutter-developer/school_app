import 'package:equatable/equatable.dart';
import '../model/student_fee_record.dart'; // Verify path

enum FeesStatus { initial, loading, success, failure }

class FeesState extends Equatable {
  // ... (fields remain the same) ...
  final FeesStatus status;
  final String? errorMessage;
  final Map<String, double> paymentStatusData;
  final Map<String, double> feeStructureData;
  final Map<String, Map<String, double>> overallTrackData;
  final List<String> overviewClassOptions;
  final List<String> overviewTermOptions;
  final String selectedOverviewClass;
  final String selectedOverviewTerm;
  final DateTime selectedOverviewDate; // The field itself
  final List<StudentFeeRecord> allStudents;
  final List<StudentFeeRecord> filteredStudents;
  final List<String> studentTypeOptions;
  final List<String> studentClassOptions;
  final List<String> studentTermOptions;
  final String selectedStudentType;
  final String selectedStudentClass;
  final String selectedStudentTerm;
  final String studentSearchQuery;

  // Constructor - REMOVED 'const'
  FeesState({
    // <--- No 'const' here
    this.status = FeesStatus.initial,
    this.errorMessage,
    // Overview Data
    this.paymentStatusData =
        const {}, // Using const here for default values is fine
    this.feeStructureData = const {},
    this.overallTrackData = const {},
    // Overview Filters
    this.overviewClassOptions = const [
      'Class V',
      'Class VI',
      'VII-A',
      'VIII-A',
      'IX-A',
      'X-A',
    ],
    this.overviewTermOptions = const [
      'Term-I',
      'Term-II',
      'Term-III',
      'Final Exam',
    ],
    this.selectedOverviewClass = 'VII-A',
    this.selectedOverviewTerm = 'Term-I',
    DateTime? initialDate, // Nullable parameter for the date
    // Student Fee Data
    this.allStudents = const [],
    this.filteredStudents = const [],
    // Student Fee Filters
    this.studentTypeOptions = const [
      'Regular',
      'Admission',
      'Hostel',
      'Scholarship',
    ],
    this.studentClassOptions = const ['VII-A', 'VIII-A', 'IX-A', 'X-A'],
    this.studentTermOptions = const [
      'Term-I',
      'Term-II',
      'Term-III',
      'Final Term',
    ],
    this.selectedStudentType = 'Regular',
    this.selectedStudentClass = 'VII-A',
    this.selectedStudentTerm = 'Term-I',
    this.studentSearchQuery = '',
  }) : selectedOverviewDate =
           initialDate ?? DateTime.now(); // Now this is allowed

  // ... (copyWith method and props list remain the same) ...
  FeesState copyWith({
    FeesStatus? status,
    Object? errorMessage = const _Undefined(),
    Map<String, double>? paymentStatusData,
    Map<String, double>? feeStructureData,
    Map<String, Map<String, double>>? overallTrackData,
    String? selectedOverviewClass,
    String? selectedOverviewTerm,
    DateTime? selectedOverviewDate,
    List<StudentFeeRecord>? allStudents,
    List<StudentFeeRecord>? filteredStudents,
    String? selectedStudentType,
    String? selectedStudentClass,
    String? selectedStudentTerm,
    String? studentSearchQuery,
    List<String>? overviewClassOptions,
    List<String>? overviewTermOptions,
    List<String>? studentTypeOptions,
    List<String>? studentClassOptions,
    List<String>? studentTermOptions,
  }) {
    final finalErrorMessage =
        errorMessage is _Undefined
            ? this.errorMessage
            : errorMessage as String?;

    // Optional: Runtime check (can be removed if not needed)
    assert(
      finalErrorMessage == null || finalErrorMessage.isNotEmpty,
      "copyWith tried to set an empty error message. Use null instead.",
    );

    // Note: We create a non-const FeesState instance here
    return FeesState(
      status: status ?? this.status,
      errorMessage: finalErrorMessage,
      paymentStatusData: paymentStatusData ?? this.paymentStatusData,
      feeStructureData: feeStructureData ?? this.feeStructureData,
      overallTrackData: overallTrackData ?? this.overallTrackData,
      overviewClassOptions: overviewClassOptions ?? this.overviewClassOptions,
      overviewTermOptions: overviewTermOptions ?? this.overviewTermOptions,
      selectedOverviewClass:
          selectedOverviewClass ?? this.selectedOverviewClass,
      selectedOverviewTerm: selectedOverviewTerm ?? this.selectedOverviewTerm,
      initialDate:
          selectedOverviewDate ??
          this.selectedOverviewDate, // Pass date correctly
      allStudents: allStudents ?? this.allStudents,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      studentTypeOptions: studentTypeOptions ?? this.studentTypeOptions,
      studentClassOptions: studentClassOptions ?? this.studentClassOptions,
      studentTermOptions: studentTermOptions ?? this.studentTermOptions,
      selectedStudentType: selectedStudentType ?? this.selectedStudentType,
      selectedStudentClass: selectedStudentClass ?? this.selectedStudentClass,
      selectedStudentTerm: selectedStudentTerm ?? this.selectedStudentTerm,
      studentSearchQuery: studentSearchQuery ?? this.studentSearchQuery,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    paymentStatusData,
    feeStructureData,
    overallTrackData,
    overviewClassOptions,
    overviewTermOptions,
    selectedOverviewClass,
    selectedOverviewTerm,
    selectedOverviewDate,
    allStudents,
    filteredStudents,
    studentTypeOptions,
    studentClassOptions,
    studentTermOptions,
    selectedStudentType,
    selectedStudentClass,
    selectedStudentTerm,
    studentSearchQuery,
  ];
}

// Helper class for copyWith
class _Undefined {
  const _Undefined();
}
