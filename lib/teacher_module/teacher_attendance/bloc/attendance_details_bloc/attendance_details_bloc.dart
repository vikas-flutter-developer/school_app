import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/models/student_model.dart' show Students;
import 'package:equatable/equatable.dart';

part 'attendance_details_event.dart';
part 'attendance_details_state.dart';

class AttendanceDetailsBloc
    extends Bloc<AttendanceDetailsEvent, AttendanceDetailsState> {
  AttendanceDetailsBloc() : super(AttendanceDetailsInitial()) {
    on<LoadAttendanceDetails>((event, emit) async {
      emit(AttendanceDetailsLoading());
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        final students = List.generate(
          6,
          (index) => Students(
            id: 'ID 0123${45 + index}',
            name: 'Student Name ${index + 1}',
            profileImagePath: 'assets/images/profile2.png',
            status: ['P', 'P', 'A', 'P', 'L', 'P'][index % 6],
            details: 'Roll No: ${101 + index}',
          ),
        );

        emit(
          AttendanceDetailsLoaded(
            students: students,
            selectedClass: event.selectedClass,
            selectedDate: event.selectedDate,
          ),
        );
      } catch (e) {
        emit(AttendanceDetailsError('Failed to load attendance details'));
      }
    });

    on<SelectClass>((event, emit) {
      if (state is AttendanceDetailsLoaded) {
        final currentState = state as AttendanceDetailsLoaded;
        emit(
          AttendanceDetailsLoaded(
            students: currentState.students,
            selectedClass: event.selectedClass,
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });

    on<SelectDate>((event, emit) {
      if (state is AttendanceDetailsLoaded) {
        final currentState = state as AttendanceDetailsLoaded;
        emit(
          AttendanceDetailsLoaded(
            students: currentState.students,
            selectedClass: currentState.selectedClass,
            selectedDate: event.selectedDate,
          ),
        );
      }
    });
  }
}
