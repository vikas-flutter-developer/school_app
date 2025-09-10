import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid.dart';
import '../../../models/ticket.dart';
import '../../common_widgets/status_chip.dart';

part 'raise_ticket_state.dart';

class RaiseTicketCubit extends Cubit<RaiseTicketState> {
  RaiseTicketCubit() : super(RaiseTicketInitial());

  // In a real app, inject a repository
  // final TicketRepository _repository;
  // RaiseTicketCubit(this._repository) : super(RaiseTicketInitial());
  // Create a Uuid instance (can be const)
  final _uuid = const Uuid(); // Create instance outside or inside the method
  Future<void> submitTicket({
    required String category,
    required String raisedBy, // This might come from user auth state
    required DateTime date,
    required String reason,
  }) async {
    try {
      emit(RaiseTicketSubmitting());

      // Simulate network delay/API call
      await Future.delayed(const Duration(seconds: 1));

      // Create a ticket object (adjust dates as needed for your logic)
      final newTicket = Ticket(
        id: _uuid.v4().substring(0, 6).toUpperCase(), // Generate mock ID
        category: category,
        startDate: date, // Or adjust based on requirements
        endDate: date.add(const Duration(days: 1)), // Example end date
        submittedDate: DateTime.now(),
        raisedBy: raisedBy,
        status: TicketStatus.Pending,
        approvalFrom: 'Management', // Default approver example
        reason: reason,
      );

      // In real app: await _repository.createTicket(newTicket);
      print('Submitting ticket: ${newTicket.id}');

      emit(RaiseTicketSuccess());
    } catch (e) {
      emit(RaiseTicketFailure('Failed to submit ticket: ${e.toString()}'));
    }
  }
}
