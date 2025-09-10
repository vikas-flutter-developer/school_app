import 'package:equatable/equatable.dart';
import '../../../models/service_request_model.dart';

abstract class ServiceRequestEvent extends Equatable {
  const ServiceRequestEvent();
  @override
  List<Object?> get props => [];
}

class LoadServiceRequests extends ServiceRequestEvent {}

class SubmitServiceRequest extends ServiceRequestEvent {
  final RequestTypes type;
  final String? productName;
  final int? quantity;
  final String? serviceType;
  final RequestPrioritys priority;
  final String? comment;

  const SubmitServiceRequest({
    required this.type,
    this.productName,
    this.quantity,
    this.serviceType,
    required this.priority,
    this.comment,
  });

  @override
  List<Object?> get props => [type, productName, quantity, serviceType, priority, comment];
}

class UpdateServiceRequestStatus extends ServiceRequestEvent {
  final String requestId;
  final RequestStatus newStatus;
  final String? actionComment; // e.g., "Contacted MSEB"

  const UpdateServiceRequestStatus(this.requestId, this.newStatus, {this.actionComment});

  @override
  List<Object?> get props => [requestId, newStatus, actionComment];
}