// create_ticket_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
// Import Repo and Models

part 'create_ticket_event.dart';
part 'create_ticket_state.dart';

class CreateTicketBloc extends Bloc<CreateTicketEvent, CreateTicketState> {
  // final HelpdeskRepository _helpdeskRepository;

  CreateTicketBloc(/*required this.helpdeskRepository*/)
    : super(CreateTicketState.initial()) {
    on<TicketTypeChanged>(_onTypeChanged);
    on<CommentChanged>(_onCommentChanged);
    on<SubmitTicket>(_onSubmitTicket);
  }

  void _onTypeChanged(
    TicketTypeChanged event,
    Emitter<CreateTicketState> emit,
  ) {
    emit(state.copyWith(selectedType: event.type));
  }

  void _onCommentChanged(
    CommentChanged event,
    Emitter<CreateTicketState> emit,
  ) {
    emit(state.copyWith(comment: event.comment));
  }

  Future<void> _onSubmitTicket(
    SubmitTicket event,
    Emitter<CreateTicketState> emit,
  ) async {
    if (state.comment.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CreateTicketStatus.failure,
          error: 'Comment cannot be empty.',
        ),
      );
      emit(
        state.copyWith(status: CreateTicketStatus.initial, error: null),
      ); // Reset status after showing error briefly
      return;
    }

    emit(state.copyWith(status: CreateTicketStatus.submitting, error: null));
    try {
      // Simulate submission
      await Future.delayed(const Duration(seconds: 1));
      // await _helpdeskRepository.createTicket(
      //   type: state.selectedType,
      //   comment: state.comment,
      //   requestId: state.requestId
      // );
      emit(state.copyWith(status: CreateTicketStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateTicketStatus.failure,
          error: 'Failed to submit ticket: $e',
        ),
      );
    }
  }
}
