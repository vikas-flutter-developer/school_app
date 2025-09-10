part of 'service_request_bloc.dart';

abstract class ServiceRequestEvent extends Equatable {
  const ServiceRequestEvent();
  @override
  List<Object> get props => [];
}

class LoadServiceRequests extends ServiceRequestEvent {}

// Add FilterServiceRequests event if needed
