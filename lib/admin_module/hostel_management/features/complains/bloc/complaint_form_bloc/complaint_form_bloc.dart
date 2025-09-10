import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complaint_form_event.dart';
part 'complaint_form_state.dart';

class ComplaintFormBloc extends Bloc<ComplaintFormEvent, ComplaintFormState> {
  ComplaintFormBloc() : super(const ComplaintFormState()) {
    on<LoadComplaintFormData>(_onLoadComplaintFormData);
    on<ActionChanged>(_onActionChanged);
    on<StatusChanged>(_onStatusChanged);
    on<ResolvedDateChanged>(_onResolvedDateChanged);
    on<CommentChanged>(_onCommentChanged);
    on<SubmitComplaintForm>(_onSubmitComplaintForm);
  }

  void _onLoadComplaintFormData(
    LoadComplaintFormData event,
    Emitter<ComplaintFormState> emit,
  ) {
    // If you need to load initial data from an existing complaint:
    // if (event.complaint != null) {
    //   emit(state.copyWith(
    //     selectedAction: event.complaint!.action,
    //     // ... and so on for other fields
    //   ));
    // } else {
    // For now, we just use the default initial state
    emit(const ComplaintFormState());
    // }
  }

  void _onActionChanged(ActionChanged event, Emitter<ComplaintFormState> emit) {
    emit(state.copyWith(selectedAction: event.action));
  }

  void _onStatusChanged(StatusChanged event, Emitter<ComplaintFormState> emit) {
    emit(state.copyWith(selectedStatus: event.status));
  }

  void _onResolvedDateChanged(
    ResolvedDateChanged event,
    Emitter<ComplaintFormState> emit,
  ) {
    emit(state.copyWith(selectedResolvedDate: event.date));
  }

  void _onCommentChanged(
    CommentChanged event,
    Emitter<ComplaintFormState> emit,
  ) {
    emit(state.copyWith(comment: event.comment));
  }

  void _onSubmitComplaintForm(
    SubmitComplaintForm event,
    Emitter<ComplaintFormState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormSubmissionStatus.submitting));
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, handle success/error based on API response
    emit(state.copyWith(submissionStatus: FormSubmissionStatus.success));
    // Optionally reset to initial after success if needed
    // emit(state.copyWith(submissionStatus: FormSubmissionStatus.initial));
  }
}
