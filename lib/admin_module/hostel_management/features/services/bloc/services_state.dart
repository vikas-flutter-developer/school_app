import 'package:equatable/equatable.dart';
import '../../../models/service_request_model.dart';

abstract class ServiceRequestState extends Equatable {
  const ServiceRequestState();
  @override
  List<Object> get props => [];
}

class ServiceRequestInitial extends ServiceRequestState {}

class ServiceRequestLoading extends ServiceRequestState {}

class ServiceRequestListLoadSuccess extends ServiceRequestState {
  final List<ServiceRequestItems> requests;
  const ServiceRequestListLoadSuccess(this.requests);
  @override
  List<Object> get props => [requests];
}

class ServiceRequestSubmissionSuccess extends ServiceRequestState {
  final String message;
  const ServiceRequestSubmissionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class ServiceRequestUpdateSuccess extends ServiceRequestState {
  final String message;
  const ServiceRequestUpdateSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class ServiceRequestError extends ServiceRequestState {
  final String message;
  const ServiceRequestError(this.message);
  @override
  List<Object> get props => [message];
}