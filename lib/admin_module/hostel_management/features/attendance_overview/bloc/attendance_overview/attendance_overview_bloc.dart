import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/room_model.dart';
import '../../models/student_short_info_model.dart';

part 'attendance_overview_event.dart';
part 'attendance_overview_state.dart';

class AttendanceOverviewBloc
    extends Bloc<AttendanceOverviewEvent, AttendanceOverviewState> {
  AttendanceOverviewBloc() : super(AttendanceOverviewInitial()) {
    on<LoadAttendanceData>((event, emit) async {
      emit(AttendanceOverviewLoading());
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));
        final List<RoomModel> rooms = [
          RoomModel(
            roomNumber: "101",
            students: [
              StudentShortInfoModel(roomSeat: "101 - 1", name: "Aditi Sehgal"),
              StudentShortInfoModel(roomSeat: "101 - 2", name: "Aditi Sehgal"),
              StudentShortInfoModel(roomSeat: "101 - 3", name: "Aditi Sehgal"),
            ],
          ),
          RoomModel(
            roomNumber: "102",
            students: [
              StudentShortInfoModel(roomSeat: "102 - 1", name: "Aditi Sehgal"),
              StudentShortInfoModel(roomSeat: "102 - 2", name: "Aditi Sehgal"),
              StudentShortInfoModel(roomSeat: "102 - 3", name: "Aditi Sehgal"),
            ],
          ),
          RoomModel(
            roomNumber: "103",
            students: [
              StudentShortInfoModel(roomSeat: "103 - 1", name: "Aditi Sehgal"),
              StudentShortInfoModel(roomSeat: "103 - 2", name: "Aditi Sehgal"),
              StudentShortInfoModel(roomSeat: "103 - 3", name: "Aditi Sehgal"),
            ],
          ),
        ];
        emit(AttendanceOverviewLoaded(rooms));
      } catch (e) {
        emit(AttendanceOverviewError("Failed to load attendance data"));
      }
    });
  }
}
