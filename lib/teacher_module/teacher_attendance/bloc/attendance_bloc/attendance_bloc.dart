import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'attendace_state.dart';

part 'attendance_event.dart';

class AttendancesBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendancesBloc() : super(AttendanceInitial()) {
    on<LoadAttendanceOptions>((event, emit) {
      emit(AttendanceOptionsLoaded());
    });
  }
}
