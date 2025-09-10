

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/student_models.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentFetchEvent, StudentState> {
  StudentBloc() : super(StudentLoadingState()) {
    on<StudentFetchEvent>((event, emit) async {
      // API call is removed. We will use dummy data.

      // 1. Show loading indicator
      emit(StudentLoadingState());

      // 2. Wait for a moment to simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // 3. Create dummy student data from the model
      final dummyStudentData = StudentModels.createDummy();

      // 4. Emit the loaded state with dummy data
      emit(StudentLoadedState(dummyStudentData));
    });
  }
}
