import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/models/student_model.dart' show Students;
import 'package:equatable/equatable.dart';

part 'update_attendance_event.dart';
part 'update_attendance_state.dart';

class UpdateAttendanceBloc
    extends Bloc<UpdateAttendanceEvent, UpdateAttendanceState> {
  UpdateAttendanceBloc() : super(UpdateAttendanceInitial()) {
    on<LoadStudents>((event, emit) async {
      emit(UpdateAttendanceLoading());
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        final students = List.generate(
          15,
          (index) => Students(
            id: '005${index + 1}',
            name: 'Student ${index + 1}',
            profileImagePath: 'assets/images/profile.jpg',
            status: ['Present', 'Absent', 'Late'][index % 3],
            details: 'Roll No: ${101 + index}',
          ),
        );

        emit(
          UpdateAttendanceLoaded(
            students: students,
            selectedClass: event.selectedClass,
            selectedDate: event.selectedDate,
          ),
        );
      } catch (e) {
        emit(UpdateAttendanceError('Failed to load students'));
      }
    });

    on<UpdateStudentStatus>((event, emit) {
      if (state is UpdateAttendanceLoaded) {
        final currentState = state as UpdateAttendanceLoaded;
        final updatedStudents =
            currentState.students.map((student) {
              if (student.id == event.studentId) {
                return student.copyWith(status: event.status);
              }
              return student;
            }).toList();

        emit(
          UpdateAttendanceLoaded(
            students: updatedStudents,
            selectedClass: currentState.selectedClass,
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });

    on<BulkUpdateStatus>((event, emit) {
      if (state is UpdateAttendanceLoaded) {
        final currentState = state as UpdateAttendanceLoaded;
        final updatedStudents =
            currentState.students
                .map((student) => student.copyWith(status: event.status))
                .toList();

        emit(
          UpdateAttendanceLoaded(
            students: updatedStudents,
            selectedClass: currentState.selectedClass,
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });

    on<SelectClass>((event, emit) {
      if (state is UpdateAttendanceLoaded) {
        final currentState = state as UpdateAttendanceLoaded;
        emit(
          UpdateAttendanceLoaded(
            students: currentState.students,
            selectedClass: event.selectedClass,
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });

    on<SelectDate>((event, emit) {
      if (state is UpdateAttendanceLoaded) {
        final currentState = state as UpdateAttendanceLoaded;
        emit(
          UpdateAttendanceLoaded(
            students: currentState.students,
            selectedClass: currentState.selectedClass,
            selectedDate: event.selectedDate,
          ),
        );
      }
    });
  }
}
