import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/service_request.dart';
import '../../../data/repositories/service_request_repository.dart';
// import '../../../models/ticket.dart'; // If merging
// import '../../../data/repositories/ticket_repository.dart'; // If merging

part 'service_request_event.dart';
part 'service_request_state.dart';

class ServiceRequestBloc
    extends Bloc<ServiceRequestEvent, ServiceRequestState> {
  final ServiceRequestRepository _serviceRequestRepository;
  // final TicketRepository _ticketRepository; // If merging

  ServiceRequestBloc({
    required ServiceRequestRepository serviceRequestRepository,
    // required TicketRepository ticketRepository, // If merging
  }) : _serviceRequestRepository = serviceRequestRepository,
       // _ticketRepository = ticketRepository, // If merging
       super(ServiceRequestInitial()) {
    on<LoadServiceRequests>(_onLoadServiceRequests);
  }

  Future<void> _onLoadServiceRequests(
    LoadServiceRequests event,
    Emitter<ServiceRequestState> emit,
  ) async {
    emit(ServiceRequestLoading());
    try {
      final serviceRequests =
          await _serviceRequestRepository.getServiceRequests();
      // final tickets = await _ticketRepository.getTickets(); // If merging
      emit(ServiceRequestLoaded(serviceRequests /*, tickets */));
    } catch (e) {
      emit(ServiceRequestError("Failed to load requests: ${e.toString()}"));
    }
  }
}
