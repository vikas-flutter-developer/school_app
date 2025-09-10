// lib/presentation/blocs/reports_insights/reports_insights_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/result.dart';
import '../../../data/models/student.dart';

part 'reports_insights_event.dart';
part 'reports_insights_state.dart';

class ReportsInsightsBloc
    extends Bloc<ReportsInsightsEvent, ReportsInsightsState> {
  // Inject Repository here: final ReportRepository _repository;
  ReportsInsightsBloc(/* required ReportRepository repository */)
    : super(const ReportsInsightsState()) /* : _repository = repository */ {
    on<LoadReportsData>(_onLoadReportsData);
    on<SelectResultClass>(_onSelectResultClass);
    on<SelectResultTerm>(_onSelectResultTerm);
  }

  Future<void> _onLoadReportsData(
    LoadReportsData event,
    Emitter<ReportsInsightsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ReportsStatus.loading,
        selectedClass: event.classId,
        selectedTerm: event.termId,
      ),
    );
    try {
      // --- Mock Data --- (Replace with repository call)
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Simulate network delay
      final results = _getMockStudentResults(event.classId, event.termId);
      final toppers = _getMockClassToppers(event.classId, event.termId);
      final performance = _getMockPerformanceData(event.classId, event.termId);
      // --- End Mock Data ---

      // Example Repository call:
      // final results = await _repository.fetchStudentResults(event.classId, event.termId);
      // final toppers = await _repository.fetchClassToppers(event.classId, event.termId);
      // final performance = await _repository.fetchClassPerformance(event.classId, event.termId);

      emit(
        state.copyWith(
          status: ReportsStatus.success,
          studentResults: results,
          classToppers: toppers,
          classPerformanceData: performance,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ReportsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSelectResultClass(
    SelectResultClass event,
    Emitter<ReportsInsightsState> emit,
  ) async {
    if (event.selectedClass != state.selectedClass) {
      // Reload data for the newly selected class and current term
      add(
        LoadReportsData(
          classId: event.selectedClass,
          termId: state.selectedTerm,
        ),
      );
    }
  }

  Future<void> _onSelectResultTerm(
    SelectResultTerm event,
    Emitter<ReportsInsightsState> emit,
  ) async {
    if (event.selectedTerm != state.selectedTerm) {
      // Here, you might only need to reload toppers and performance data
      // Or reload everything if results table also depends on term filter implicitly
      // For simplicity, reloading all based on the current implementation:
      add(
        LoadReportsData(
          classId: state.selectedClass,
          termId: event.selectedTerm,
        ),
      );
      // Alternatively, emit state change directly if data is already filtered/available
      // emit(state.copyWith(selectedTerm: event.selectedTerm, /* update relevant data */));
    }
  }

  // --- Mock Data Generation (Replace with actual data fetching) ---
  List<StudentResultSummary> _getMockStudentResults(
    String classId,
    String termId,
  ) {
    if (classId == 'VIII-A' && termId == 'Term-I') {
      return const [
        StudentResultSummary(
          studentId: 's1',
          studentName: 'Ansh Gupta',
          subject: 'Science',
          examTerm: 'Term-I',
          status: ResultStatus.Pass,
        ),
        StudentResultSummary(
          studentId: 's1',
          studentName: 'Ansh Gupta',
          subject: 'Science',
          examTerm: 'Term-I',
          status: ResultStatus.Pass,
        ), // Duplicate? Mockup shows this
        StudentResultSummary(
          studentId: 's1',
          studentName: 'Ansh Gupta',
          subject: 'Science',
          examTerm: 'Term-I',
          status: ResultStatus.Pass,
        ), // Duplicate?
        StudentResultSummary(
          studentId: 's1',
          studentName: 'Ansh Gupta',
          subject: 'Science',
          examTerm: 'Term-I',
          status: ResultStatus.Fail,
        ), // Duplicate?
        StudentResultSummary(
          studentId: 's1',
          studentName: 'Ansh Gupta',
          subject: 'Science',
          examTerm: 'Term-I',
          status: ResultStatus.Pass,
        ), // Duplicate?
        StudentResultSummary(
          studentId: 's2',
          studentName: 'Shreya M',
          subject: 'Maths',
          examTerm: 'Term-I',
          status: ResultStatus.Pass,
        ),
        StudentResultSummary(
          studentId: 's3',
          studentName: 'Rashmika K',
          subject: 'English',
          examTerm: 'Term-I',
          status: ResultStatus.Pass,
        ),
      ];
    }
    return []; // Default empty
  }

  List<Student> _getMockClassToppers(String classId, String termId) {
    if (classId == 'VIII-A' && termId == 'Term-I') {
      return [
        Student(
          id: 's2',
          name: 'Kushal',
          className: classId,
          rollNo: '001',
          rank: 1,
          photoUrl: 'assets/images/av1.png',
          academicYear: '2024-2025',
          admissionNumber: 'ADM123',
          dateOfAdmission: DateTime.now(),
        ), // Placeholder URLs
        Student(
          id: 's1',
          name: 'Vikas',
          className: classId,
          rollNo: '0056',
          rank: 2,
          photoUrl: 'assets/images/av2.png',
          academicYear: '2024-2025',
          admissionNumber: '51131714049',
          dateOfAdmission: DateTime(2024, 7, 2),
        ),
        Student(
          id: 's3',
          name: 'Gaurav',
          className: classId,
          rollNo: '003',
          rank: 3,
          photoUrl:'assets/images/av3.png',
          academicYear: '2024-2025',
          admissionNumber: 'ADM456',
          dateOfAdmission: DateTime.now(),
        ),
      ];
    }
    return [];
  }

  dynamic _getMockPerformanceData(String classId, String termId) {
    // Return data structure suitable for your charting library (e.g., list of points)
    if (classId == 'VIII-A' && termId == 'Term-I') {
      return {
        'subjects': [
          'Science',
          'Social Studies',
          'English',
          'Maths',
          'Computer',
        ],
        'theory': [65.0, 62.0, 70.0, 68.0, 75.0],
        'practical': [50.0, 55.0, 45.0, 58.0, 60.0],
      };
    }
    return null;
  }
}

// --- Student Report BLoC (Similar structure) ---
// lib/presentation/blocs/student_report/student_report_event.dart
// Events: LoadStudentReport(studentId, termId), SelectStudentTerm(termId), NavigateStudent(direction)

// lib/presentation/blocs/student_report/student_report_state.dart
// State: status, studentDetails (Student model), selectedTerm, subjectResults (List<SubjectResultDetail>), performanceData, rank, errorMessage, availableTerms

// lib/presentation/blocs/student_report/student_report_bloc.dart
// Bloc: Handles events, fetches individual student data, updates state.

// --- Exam Overview BLoC (Similar structure) ---
// lib/presentation/blocs/exam_overview/exam_overview_event.dart
// Events: LoadExamOverview(classId, termId, month, subject), SelectExamClass, SelectExamTerm, SelectExamMonth, SelectExamSubject, SwitchExamTab(tabIndex)

// lib/presentation/blocs/exam_overview/exam_overview_state.dart
// State: status, selectedClass, selectedTerm, selectedMonth, selectedSubject, activeTabIndex (0 for Plan, 1 for Timetable), examPlanItems (List<ExamPlanItem>), examTimetableItems (List<ExamTimetableItem>), errorMessage, availableClasses, availableTerms, availableSubjects, availableMonths

// lib/presentation/blocs/exam_overview/exam_overview_bloc.dart
// Bloc: Handles events, fetches exam data based on filters and active tab, updates state.
