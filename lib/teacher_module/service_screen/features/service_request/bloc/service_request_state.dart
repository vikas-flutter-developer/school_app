part of 'service_request_bloc.dart';

abstract class ServiceRequestState extends Equatable {
  const ServiceRequestState();
  @override
  List<Object> get props => [];
}

class ServiceRequestInitial extends ServiceRequestState {}

class ServiceRequestLoading extends ServiceRequestState {}

class ServiceRequestLoaded extends ServiceRequestState {
  final List<ServiceRequest> serviceRequests;
  // Add tickets too if merging views
  // final List<Ticket> tickets;

  const ServiceRequestLoaded(this.serviceRequests /*, this.tickets*/);
  @override
  List<Object> get props => [serviceRequests /*, tickets*/];
}

class ServiceRequestError extends ServiceRequestState {
  final String message;
  const ServiceRequestError(this.message);
  @override
  List<Object> get props => [message];
}
