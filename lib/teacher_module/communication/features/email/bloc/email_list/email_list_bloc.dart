// email_list_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// Import Repo and Models

part 'email_list_event.dart';
part 'email_list_state.dart';

class EmailListBloc extends Bloc<EmailListEvent, EmailListState> {
  // final EmailRepository _emailRepository;

  EmailListBloc(/*required this.emailRepository*/)
    : super(const EmailListState()) {
    on<LoadEmails>(_onLoadEmails);
    on<SearchEmailsChanged>(_onSearchChanged);
    on<DeleteEmail>(_onDeleteEmail);

    add(LoadEmails()); // Initial load
  }

  Future<void> _onLoadEmails(
    LoadEmails event,
    Emitter<EmailListState> emit,
  ) async {
    emit(state.copyWith(status: EmailListStatus.loading));
    try {
      // final emails = await _emailRepository.getEmails(searchTerm: state.searchTerm);
      await Future.delayed(const Duration(milliseconds: 400)); // Simulate load
      emit(
        state.copyWith(
          status: EmailListStatus.success,
          emails: EmailListState.dummyEmails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: EmailListStatus.failure, error: e.toString()),
      );
    }
  }

  void _onSearchChanged(
    SearchEmailsChanged event,
    Emitter<EmailListState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.searchTerm));
    // Debounce or directly trigger load
    add(LoadEmails()); // Reload emails with new search term
  }

  Future<void> _onDeleteEmail(
    DeleteEmail event,
    Emitter<EmailListState> emit,
  ) async {
    // Add logic to delete email via repository
    // Optimistically remove from list or reload after deletion
    final updatedEmails =
        state.emails.where((e) => e.id != event.emailId).toList();
    emit(state.copyWith(emails: updatedEmails));
    // Handle potential errors during deletion
  }
}
