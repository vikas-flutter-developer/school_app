import 'package:bloc/bloc.dart';
import '../model/Attendance_model.dart';
import 'Attendance_event.dart';
import 'Attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceLoading()) {
    on<LoadAttendance>((event, emit) {
      // Dummy hardcoded data, replace with your data source
      final attendanceList = [
        AttendanceRecord(name: "Mayuri Shah", role: "Teaching", status: "P"),
        AttendanceRecord(name: "Amay Pande", role: "Teaching", status: "A"),
        AttendanceRecord(name: "Avisnsh Dighe", role: "Admin", status: "L"),
        AttendanceRecord(name: "Mayuri Shah", role: "Teaching", status: "P"),
        AttendanceRecord(name: "Amay Pande", role: "Teaching", status: "A"),
        AttendanceRecord(name: "Avisnsh Dighe", role: "Admin", status: "L"),
        AttendanceRecord(name: "Mayuri Shah", role: "Teaching", status: "P"),
        AttendanceRecord(name: "Amay Pande", role: "Teaching", status: "A"),
        AttendanceRecord(name: "Avisnsh Dighe", role: "Admin", status: "L"),
        // more records...
        // more records...
      ];
      emit(AttendanceLoaded(attendanceList));
    });
  }
}
