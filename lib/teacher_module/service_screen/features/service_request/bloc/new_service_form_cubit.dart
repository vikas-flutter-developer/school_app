import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/service_request_repository.dart';
import 'new_service_form_state.dart'; // Interface dependency
// Link cubit to its state file

/// Manages the state for the New Service Form submission process.
class NewServiceFormCubit extends Cubit<NewServiceFormState> {
  final ServiceRequestRepository _serviceRequestRepository;

  /// Creates a new instance of [NewServiceFormCubit].
  ///
  /// Requires a [ServiceRequestRepository] to handle the actual submission.
  NewServiceFormCubit({required ServiceRequestRepository repository})
    : _serviceRequestRepository = repository,
      super(const NewServiceFormState()); // Initialize with the default state

  /// Attempts to submit the service request form data.
  ///
  /// Emits [FormStatus.submitting] state, then attempts submission via the repository.
  /// Emits [FormStatus.success] on successful submission.
  /// Emits [FormStatus.failure] with an error message if submission fails.
  Future<void> submitForm(Map<String, dynamic> formData) async {
    // Don't allow submission if already submitting
    if (state.status == FormStatus.submitting) return;

    emit(state.copyWith(status: FormStatus.submitting));

    try {
      // --- Optional: Add Domain-Level Validation ---
      // You could add validation here that's independent of the UI Form validation
      // e.g., checking if certain combinations of fields are valid.
      // if (!isFormDataValid(formData)) {
      //   throw ValidationException("Invalid form data combination.");
      // }
      // -------------------------------------------

      // Call the repository to perform the submission
      await _serviceRequestRepository.submitServiceRequest(formData);

      // On success, emit the success state (copyWith automatically clears error)
      emit(state.copyWith(status: FormStatus.success, errorMessage: null));
    } catch (e) {
      // On failure, emit the failure state with the error message
      // Log the error for debugging purposes
      print(
        'Error submitting service request: $e',
      ); // Replace with proper logging if available
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage:
              e.toString(), // Provide a user-friendly message if possible
        ),
      );
    }
  }
}
