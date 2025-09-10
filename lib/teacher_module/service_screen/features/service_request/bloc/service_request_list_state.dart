part of 'service_request_list_cubit.dart';

abstract class ServiceRequestListState extends Equatable {
  const ServiceRequestListState();

  @override
  List<Object> get props => [];
}

class ServiceRequestListInitial extends ServiceRequestListState {}

class ServiceRequestListLoading extends ServiceRequestListState {}

class ServiceRequestListLoaded extends ServiceRequestListState {
  final List<ServiceRequest> requests;
  final String? searchTerm; // Keep track of search term

  const ServiceRequestListLoaded(this.requests, {this.searchTerm});

  @override
  List<Object> get props => [requests, searchTerm ?? ''];
}

class ServiceRequestListError extends ServiceRequestListState {
  final String message;

  const ServiceRequestListError(this.message);

  @override
  List<Object> get props => [message];
}
