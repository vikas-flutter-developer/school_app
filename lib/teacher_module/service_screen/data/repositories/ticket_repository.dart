import '../../models/ticket.dart';
import '../../models/enums.dart';

abstract class TicketRepository {
  Future<List<Ticket>> getTickets();
  Future<void> submitTicket(Map<String, dynamic> formData);
}
