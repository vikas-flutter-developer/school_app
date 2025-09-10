import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/models/attendance_report_model.dart' show AttendanceReport;
import 'package:equatable/equatable.dart';

part 'attendance_report_event.dart';
part 'attendance_report_state.dart';

class AttendanceReportBloc
    extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  AttendanceReportBloc() : super(AttendanceReportInitial()) {
    on<LoadAttendanceReport>((event, emit) async {
      emit(AttendanceReportLoading());
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        final reports = List.generate(
          12,
          (index) => AttendanceReport(
            studentId: '0123${index + 1}',
            studentName:
                'Student ${['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'][index]}',
            attendance: {
              '6/01': index % 3 == 0 ? 'A' : 'P',
              '7/01': 'P',
              '8/01': index % 5 == 0 ? 'L' : 'P',
              '9/01': 'P',
              '10/01': index % 4 == 0 ? 'H' : 'P',
              '11/01': 'P',
              '12/01': 'P',
              '13/01': 'P',
            },
          ),
        );

        emit(
          AttendanceReportLoaded(
            reports: reports,
            selectedClass: event.selectedClass,
            fromDate: event.fromDate,
            toDate: event.toDate,
            tabIndex: event.tabIndex,
          ),
        );
      } catch (e) {
        emit(AttendanceReportError('Failed to load attendance report'));
      }
    });

    on<SearchStudents>((event, emit) {
      if (state is AttendanceReportLoaded) {
        final currentState = state as AttendanceReportLoaded;
        emit(
          AttendanceReportLoaded(
            reports: currentState.reports,
            selectedClass: currentState.selectedClass,
            fromDate: currentState.fromDate,
            toDate: currentState.toDate,
            tabIndex: currentState.tabIndex,
            searchQuery: event.query,
          ),
        );
      }
    });

    on<ChangeTab>((event, emit) {
      if (state is AttendanceReportLoaded) {
        final currentState = state as AttendanceReportLoaded;
        emit(
          AttendanceReportLoaded(
            reports: currentState.reports,
            selectedClass: currentState.selectedClass,
            fromDate: currentState.fromDate,
            toDate: currentState.toDate,
            tabIndex: event.tabIndex,
            searchQuery: currentState.searchQuery,
          ),
        );
      }
    });
  }
}
