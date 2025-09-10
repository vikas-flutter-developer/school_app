import 'package:bloc/bloc.dart';

import '../../models/assignment_model.dart' show Assignment;
import 'assignment_event.dart';
import 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(AssignmentInitial()) {
    on<LoadAssignments>(_onLoadAssignments);
  }

  Future<void> _onLoadAssignments(
    LoadAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(AssignmentLoading());
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));

      final submittedAssignments = List.generate(
        5,
        (index) => Assignment(subject: 'Science', isSubmitted: true),
      );

      final assignedAssignments = List.generate(
        5,
        (index) => Assignment(subject: 'Science', isSubmitted: false),
      );

      emit(
        AssignmentLoaded(
          submittedAssignments: submittedAssignments,
          assignedAssignments: assignedAssignments,
        ),
      );
    } catch (e) {
      emit(AssignmentError(message: e.toString()));
    }
  }
}
