import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/ticket.dart';
import '../../common_widgets/status_chip.dart';
// Import Status enum if needed separately, otherwise it's in StatusChip.dart
// import 'package:ticket_app/features/common/widgets/status_chip.dart';

part 'ticket_list_state.dart';

class TicketListCubit extends Cubit<TicketListState> {
  TicketListCubit() : super(TicketListInitial());

  // In a real app, inject a repository here:
  // final TicketRepository _repository;
  // TicketListCubit(this._repository) : super(TicketListInitial());

  Future<void> fetchTickets() async {
    try {
      emit(TicketListLoading());
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Replace with actual data fetching logic (e.g., _repository.getTickets())
      final tickets = Ticket.generateMockTickets();

      emit(TicketListLoaded(tickets));
    } catch (e) {
      emit(TicketListError('Failed to load tickets: ${e.toString()}'));
    }
  }

  Future<void> cancelTicket(String ticketId) async {
    if (state is TicketListLoaded) {
      final currentState = state as TicketListLoaded;
      // Simulate API call or local update
      print('Cancelling ticket: $ticketId');
      // Find and remove the ticket (or update its status)
      // For demo, we'll just remove it visually
      final updatedTickets =
          currentState.tickets.where((t) => t.id != ticketId).toList();
      emit(TicketListLoading()); // Optional: show loading during update
      await Future.delayed(
        const Duration(milliseconds: 200),
      ); // Simulate update delay
      emit(TicketListLoaded(updatedTickets));

      // In a real app:
      // try {
      //   await _repository.cancelTicket(ticketId);
      //   fetchTickets(); // Re-fetch the list to confirm
      // } catch (e) {
      //   // Handle error, maybe show a snackbar
      //   emit(currentState); // Revert to previous state on error
      // }
    }
  }

  // Add filter logic here if needed
  void filterTickets(TicketStatus? status) {
    if (state is TicketListLoaded) {
      final allTickets = Ticket.generateMockTickets(); // Get original list
      if (status == null) {
        emit(TicketListLoaded(allTickets)); // Show all
      } else {
        final filtered = allTickets.where((t) => t.status == status).toList();
        emit(TicketListLoaded(filtered));
      }
    }
  }
}
