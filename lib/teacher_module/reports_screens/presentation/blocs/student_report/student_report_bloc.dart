// --- Student Report Bloc ---
// lib/presentation/blocs/student_report/student_report_bloc.dart
import 'dart:math'; // For mock data generation
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/result.dart';
import '../../../data/models/student.dart'; // Import models

part 'student_report_event.dart';
part 'student_report_state.dart';

class StudentReportBloc extends Bloc<StudentReportEvent, StudentReportState> {
  // Inject Repository here if needed: final StudentRepository _repository;

  // Store the current student ID to refetch term data
  String _currentStudentId = '';

  StudentReportBloc(/* required StudentRepository repository */)
    : super(const StudentReportState()) /* : _repository = repository */ {
    on<LoadStudentReport>(_onLoadStudentReport);
    on<SelectStudentTerm>(_onSelectStudentTerm);
  }

  Future<void> _onLoadStudentReport(
    LoadStudentReport event,
    Emitter<StudentReportState> emit,
  ) async {
    emit(state.copyWith(status: StudentReportStatus.loading, clearError: true));
    _currentStudentId = event.studentId; // Store the student ID

    try {
      // Simulate fetching all data for the student and the initial term
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); // Simulate network delay

      final studentDetails = _getMockStudentDetails(event.studentId);
      if (studentDetails == null) {
        throw Exception("Student not found");
      }

      final results = _getMockSubjectResults(
        event.studentId,
        event.initialTermId,
      );
      final performanceData = _getMockStudentPerformanceData(
        event.studentId,
        event.initialTermId,
      );
      final availableTerms =
          _getMockAvailableTerms(); // Usually same for the class

      emit(
        state.copyWith(
          status: StudentReportStatus.success,
          studentDetails: studentDetails,
          selectedTerm: event.initialTermId, // Set the loaded term
          subjectResults: results,
          studentPerformanceData: performanceData,
          availableTerms: availableTerms,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentReportStatus.failure,
          errorMessage: "Failed to load student report: ${e.toString()}",
          studentDetails: null, // Clear details on error
          subjectResults: [],
          studentPerformanceData: null,
        ),
      );
    }
  }

  Future<void> _onSelectStudentTerm(
    SelectStudentTerm event,
    Emitter<StudentReportState> emit,
  ) async {
    // Only proceed if the term actually changed and we have a student loaded
    if (event.selectedTermId == state.selectedTerm ||
        state.studentDetails == null) {
      return;
    }

    // Show loading specifically for term data, keep existing student details
    emit(
      state.copyWith(
        status: StudentReportStatus.loading,
        selectedTerm: event.selectedTermId,
        clearError: true,
      ),
    );

    try {
      // Simulate fetching only data relevant to the new term
      await Future.delayed(const Duration(milliseconds: 400));

      final results = _getMockSubjectResults(
        _currentStudentId,
        event.selectedTermId,
      );
      final performanceData = _getMockStudentPerformanceData(
        _currentStudentId,
        event.selectedTermId,
      );

      emit(
        state.copyWith(
          status: StudentReportStatus.success,
          // Keep existing studentDetails: state.studentDetails,
          selectedTerm: event.selectedTermId, // Update selected term
          subjectResults: results, // Update results
          studentPerformanceData: performanceData, // Update performance data
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentReportStatus.failure,
          // Keep existing studentDetails: state.studentDetails,
          errorMessage:
              "Failed to load data for ${event.selectedTermId}: ${e.toString()}",
          // Optionally revert selected term or clear results on failure
          // selectedTerm: state.selectedTerm, // Revert term selection
          subjectResults: [],
          studentPerformanceData: null,
        ),
      );
    }
  }

  // --- Mock Data Generation (Replace with actual data fetching) ---

  Student? _getMockStudentDetails(String studentId) {
    // Find the student (e.g., from a predefined list or based on ID)
    if (studentId == 's1') {
      // Ansh Gupta from the previous example
      return Student(
        id: 's1',
        name: 'Ansh Gupta',
        className: 'VII-A', // Mockup shows VII-A for this student
        rollNo: '0056',
        rank: 2, // Example rank from first mockup
        photoUrl:
            'https://via.placeholder.com/150/772CE8/FFFFFF?text=Ansh+G', // Different placeholder
        academicYear: '2023-2024',
        admissionNumber: '51131714049',
        dateOfAdmission: DateTime(2024, 7, 2),
      );
    }
    if (studentId == 's_rank10') {
      // Example for Rank 10 mockup
      return Student(
        id: 's_rank10',
        name: 'Ansh Gupta', // Same name used in mockup
        className: 'VII-A',
        rollNo: '0056', // Same roll no used
        rank: 10, // Rank from second mockup
        photoUrl:
            'https://via.placeholder.com/150/772CE8/FFFFFF?text=Ansh+G', // Placeholder
        academicYear: '2023-2024',
        admissionNumber: '51131714049',
        dateOfAdmission: DateTime(2024, 7, 2),
      );
    }
    // Add other mock students as needed
    return null; // Student not found
  }

  List<SubjectResultDetail> _getMockSubjectResults(
    String studentId,
    String termId,
  ) {
    // Generate slightly different results based on term or student ID for variety
    final random = Random(studentId.hashCode + termId.hashCode);
    final subjects = ['Science', 'Social', 'English', 'Maths', 'Computer'];
    List<SubjectResultDetail> results = [];

    for (var subject in subjects) {
      int score = 65 + random.nextInt(26); // Score between 65 and 90
      bool passed = score >= 40; // Example pass mark
      results.add(
        SubjectResultDetail(
          subject: subject,
          totalMarks: 100,
          score: score,
          percentage: score.toDouble(),
          result: passed ? ResultStatus.Pass : ResultStatus.Fail,
          // Mock theory/practical breakdown (optional)
          theoryScore: (score * 0.7).round(),
          practicalScore: (score * 0.3).round(),
        ),
      );
    }
    // Simulate a lower score for Rank 10 student in Term-I
    if (studentId == 's_rank10' && termId == 'Term-I') {
      results[3] = results[3].copyWith(
        score: 55,
        percentage: 55.0,
      ); // Lower Maths score
    }

    return results;
  }

  dynamic _getMockStudentPerformanceData(String studentId, String termId) {
    final random = Random(
      studentId.hashCode + termId.hashCode + 1,
    ); // Different seed
    final subjects = [
      'Science',
      'Social Studies',
      'English',
      'Maths',
      'Computer',
    ];
    List<double>? theory = [];
    List<double>? practical = [];

    for (int i = 0; i < subjects.length; i++) {
      theory.add((60 + random.nextInt(31)).toDouble()); // 60-90
      practical.add((40 + random.nextInt(31)).toDouble()); // 40-70
    }

    // Simulate slightly lower performance for Rank 10 student
    if (studentId == 's_rank10' && termId == 'Term-I') {
      theory =
          theory
              .map((s) => max(30, s - 10))
              .cast<double>()
              .toList(); // Decrease theory scores
      practical =
          practical
              .map((s) => max(25, s - 8))
              .cast<double>()
              .toList(); // Decrease practical scores
    }

    return {'subjects': subjects, 'theory': theory, 'practical': practical};
  }

  List<String> _getMockAvailableTerms() {
    return ['Term-I', 'Term-II', 'Final Exam']; // Example terms
  }
}

// Helper extension for copyWith on SubjectResultDetail if needed
extension SubjectResultDetailCopyWith on SubjectResultDetail {
  SubjectResultDetail copyWith({
    String? subject,
    int? totalMarks,
    int? score,
    double? percentage,
    ResultStatus? result,
    int? theoryScore,
    int? practicalScore,
  }) {
    return SubjectResultDetail(
      subject: subject ?? this.subject,
      totalMarks: totalMarks ?? this.totalMarks,
      score: score ?? this.score,
      percentage: percentage ?? this.percentage,
      result: result ?? this.result,
      theoryScore: theoryScore ?? this.theoryScore,
      practicalScore: practicalScore ?? this.practicalScore,
    );
  }
}
