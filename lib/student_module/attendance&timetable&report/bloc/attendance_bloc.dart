// lib/attendance/bloc/attendance_bloc.dart

// import 'package:edudibon_flutter_bloc/data/attendance_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'attendance_event.dart';
// import 'attendance_state.dart';


// class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
//   final AttendanceRepository attendanceRepository;
//
//   AttendanceBloc({required this.attendanceRepository}) : super(AttendanceInitial()) {
//     on<FetchAttendance>(_onFetchAttendance);
//   }
//
//   Future<void> _onFetchAttendance(FetchAttendance event, Emitter<AttendanceState> emit) async {
//     emit(AttendanceLoading());
//     try {
//       final calendarEvents = await attendanceRepository.fetchCalendar(event.fromDate, event.toDate);
//       emit(AttendanceLoaded(calendarEvents: calendarEvents));
//     } catch (e) {
//       emit(AttendanceError(message: e.toString()));
//     }
//   }
// }
// attendance_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/attendance_repo.dart';
import '../model/attendance_model.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository attendanceRepository;
  final bool useStaticData;

  AttendanceBloc({
    required this.attendanceRepository,
    this.useStaticData = false, // default: fetch from API
  }) : super(AttendanceInitial()) {
    on<FetchAttendance>(_onFetchAttendance);
  }

  Future<void> _onFetchAttendance(
      FetchAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final List<CalendarEvent> calendarEvents;

      if (useStaticData) {
        // Static dummy data matching your CalendarEvent model
        calendarEvents = [
          CalendarEvent(
            cdate: "2025-08-10",
            dayOfWeek: "Monday",
            dayType: "Present",
            description: "Math class attended",
            id: 1,
            name: "Math",
          ),
          CalendarEvent(
            cdate: "2025-08-09",
            dayOfWeek: "Sunday",
            dayType: "Absent",
            description: "Science class missed",
            id: 2,
            name: "Science",
          ),
          CalendarEvent(
            cdate: "2025-08-08",
            dayOfWeek: "Saturday",
            dayType: "Present",
            description: "English class attended",
            id: 3,
            name: "English",
          ),
        ];
      } else {
        // Fetch real data from repository/API
        calendarEvents = await attendanceRepository.fetchCalendar(
          event.fromDate,
          event.toDate,
        );
      }

      emit(AttendanceLoaded(calendarEvents: calendarEvents));
    } catch (e) {
      emit(AttendanceError(message: e.toString()));
    }
  }
}

