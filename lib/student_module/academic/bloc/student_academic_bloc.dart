import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/student_module/academic/bloc/student_academic_event.dart';
import 'package:edudibon_flutter_bloc/student_module/academic/bloc/student_academic_state.dart';
import '../model/student_report_model.dart';

class AppConstants {
  static const String annualExam = 'Annual Exam';
  static const String quarterYearly = 'Quarter yearly';
  static const String halfYearly = 'Half yearly';
}


class StudentAcademicBloc extends Bloc<StudentAcademicEvent, StudentAcademicState> {
  StudentAcademicBloc() : super(StudentReportInitial()) {
    on<FetchStudentReport>(_onFetchStudentReport);
  }

  Future<void> _onFetchStudentReport(
      FetchStudentReport event,
      Emitter<StudentAcademicState> emit,
      ) async {
    emit(StudentReportLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final StudentReportModel mockReport = _getMockDataForExam(event.examType);
      emit(StudentReportLoaded(mockReport, selectedExamType: event.examType));
    } catch (e) {
      emit(StudentReportError("Failed to fetch report: ${e.toString()}"));
    }
  }

  // Helper function to create different data for different exams.
  StudentReportModel _getMockDataForExam(String examType) {
    switch (examType) {
      case AppConstants.quarterYearly:
        return const StudentReportModel(
          rank: 15,
          totalResult: "Pass",
          scores: [
            SubjectScore(srNo: 1, subject: 'Science', score: 75, percentage: 75.0, result: "Pass", total: 100),
            SubjectScore(srNo: 2, subject: 'Maths', score: 82, percentage: 82.0, result: "Pass", total: 100),
          ],
          performanceData: [60, 70, 75, 82, 78, 85],
        );
      case AppConstants.halfYearly:
        return const StudentReportModel(
          rank: 12,
          totalResult: "Pass",
          scores: [
            SubjectScore(srNo: 1, subject: 'Science', score: 80, percentage: 80.0, result: "Pass", total: 100),
            SubjectScore(srNo: 2, subject: 'Social', score: 88, percentage: 88.0, result: "Pass", total: 100),
            SubjectScore(srNo: 3, subject: 'Maths', score: 90, percentage: 90.0, result: "Pass", total: 100),
          ],
          performanceData: [70, 75, 80, 88, 90, 85],
        );
      case AppConstants.annualExam:
        return const StudentReportModel(
          rank: 10,
          totalResult: "Pass",
          scores: [
            SubjectScore(srNo: 1, subject: 'Science', score: 85, percentage: 85.0, result: "Pass", total: 100),
            SubjectScore(srNo: 2, subject: 'Social', score: 92, percentage: 92.0, result: "Pass", total: 100),
            SubjectScore(srNo: 3, subject: 'English', score: 78, percentage: 78.0, result: "Pass", total: 100),
            SubjectScore(srNo: 4, subject: 'Maths', score: 95, percentage: 95.0, result: "Pass", total: 100),
            SubjectScore(srNo: 5, subject: 'History', score: 88, percentage: 88.0, result: "Pass", total: 100),
          ],
          performanceData: [70, 80, 75, 95, 85, 92],
        );
      default:
        return const StudentReportModel(
          rank: 0,
          totalResult: "Data Not Available",
          scores: [],
          performanceData: [],
        );
    }
  }
}
