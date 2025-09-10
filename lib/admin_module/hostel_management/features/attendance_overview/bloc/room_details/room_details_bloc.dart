import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../models/student_card_model.dart';

part 'room_details_event.dart';
part 'room_details_state.dart';

class AttendanceRoomDetailsBloc extends Bloc<RoomDetailsEvent, RoomDetailsState> {
  AttendanceRoomDetailsBloc() : super(RoomDetailsInitial()) {
    on<AttendanceLoadRoomDetails>((event, emit){
      emit(RoomDetailsLoading());
      try {
        // Simulate API call based on event.roomId
        Future.delayed(const Duration(seconds: 1));
        final List<StudentCardModel> students = [
          StudentCardModel(
            roomSeat: '101- 1',
            name: 'Mayuri Shah',
            email: 'mayurishah@gmail.com',
            phone: '+91 78869 56775',
            department: 'Civil Engineering',
            year: '1st Year',
            profileImageUrl: 'assets/images/profileimage.png',
            status: 'Checked In',
            statusText: 'Check In',
            statusColor: AppColors.success,
            time: '04:00pm',
          ),
          StudentCardModel(
            roomSeat: '101- 2',
            name: 'Rohan Verma',
            email: 'rohanverma@example.com',
            phone: '+91 98765 43210',
            department: 'Computer Science',
            year: '2nd Year',
            profileImageUrl:
                'assets/images/profileimage.png', // Use a different image or placeholder
            status: 'Pending',
            statusText:
                'Check In', // statusText should likely align with 'status'
            statusColor: AppColors.warning,
            time: '04:15pm',
          ),
          StudentCardModel(
            roomSeat: '101- 3',
            name: 'Priya Singh',
            email: 'priyasingh@example.com',
            phone: '+91 87654 32109',
            department: 'Mechanical Engineering',
            year: '1st Year',
            profileImageUrl:
                'assets/images/profileimage.png', // Use a different image or placeholder
            status: 'On leave',
            statusText: 'On leave',
            statusColor: AppColors.error,
            time: '', // No time for 'On leave'
          ),
        ];
        emit(RoomDetailsLoaded(students, "Room ${event.roomId} Details"));
      } catch (e) {
        emit(
          RoomDetailsError("Failed to load room details for ${event.roomId}"),
        );
      }
    });
  }
}
