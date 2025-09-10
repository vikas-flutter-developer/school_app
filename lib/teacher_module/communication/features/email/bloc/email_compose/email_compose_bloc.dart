// email_compose_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// Import Repos and Models

part 'email_compose_event.dart';
part 'email_compose_state.dart';

class EmailComposeBloc extends Bloc<EmailComposeEvent, EmailComposeState> {
  // final EmailRepository _emailRepository;
  // final RecipientRepository _recipientRepository; // For fetching groups

  EmailComposeBloc(/* ...repositories... */)
    : super(const EmailComposeState()) {
    on<LoadComposeData>(_onLoadData);
    on<SenderSelected>(_onSenderSelected);
    on<RecipientGroupToggled>(_onRecipientGroupToggled);
    on<SubjectChanged>(_onSubjectChanged);
    on<BodyChanged>(_onBodyChanged);
    on<SendEmail>(_onSendEmail);

    add(LoadComposeData()); // Initial load
  }

  Future<void> _onLoadData(
    LoadComposeData event,
    Emitter<EmailComposeState> emit,
  ) async {
    emit(state.copyWith(status: EmailComposeStatus.loading));
    try {
      // Simulate loading 'From' options and recipient groups
      await Future.delayed(const Duration(milliseconds: 200));
      final fromOptions = [
        'principal@edudibon.com',
        'info@edudibon.com',
      ]; // Example
      final groups = RecipientGroup.dummyGroups;

      emit(
        state.copyWith(
          status: EmailComposeStatus.ready,
          fromOptions: fromOptions,
          selectedFrom:
              fromOptions.isNotEmpty
                  ? fromOptions.first
                  : null, // Default selection
          availableRecipientGroups: groups,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: EmailComposeStatus.failure,
          error: 'Failed to load data',
        ),
      );
    }
  }

  void _onSenderSelected(
    SenderSelected event,
    Emitter<EmailComposeState> emit,
  ) {
    emit(state.copyWith(selectedFrom: event.senderEmail));
  }

  void _onRecipientGroupToggled(
    RecipientGroupToggled event,
    Emitter<EmailComposeState> emit,
  ) {
    final currentSelection = Set<String>.from(state.selectedRecipientGroupIds);
    if (event.isSelected) {
      currentSelection.add(event.groupName); // Use group name or ID
    } else {
      currentSelection.remove(event.groupName);
    }
    // Special handling for "All Parents" vs "Parent list" if needed
    // e.g., if "All Parents" is selected, deselect "Parent list"

    emit(state.copyWith(selectedRecipientGroupIds: currentSelection));
  }

  void _onSubjectChanged(
    SubjectChanged event,
    Emitter<EmailComposeState> emit,
  ) {
    emit(state.copyWith(subject: event.subject));
  }

  void _onBodyChanged(BodyChanged event, Emitter<EmailComposeState> emit) {
    emit(state.copyWith(body: event.body));
  }

  Future<void> _onSendEmail(
    SendEmail event,
    Emitter<EmailComposeState> emit,
  ) async {
    if (state.selectedFrom == null ||
        state.selectedRecipientGroupIds.isEmpty ||
        state.subject.isEmpty ||
        state.body.isEmpty) {
      emit(state.copyWith(error: 'Please fill all required fields.'));
      return;
    }
    emit(state.copyWith(status: EmailComposeStatus.sending, error: null));
    try {
      // Simulate sending email
      await Future.delayed(const Duration(seconds: 1));
      // await _emailRepository.sendEmail(
      //   from: state.selectedFrom!,
      //   recipientGroupIds: state.selectedRecipientGroupIds,
      //   subject: state.subject,
      //   body: state.body,
      // );
      emit(state.copyWith(status: EmailComposeStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: EmailComposeStatus.failure,
          error: 'Failed to send email: $e',
        ),
      );
    }
  }
}
