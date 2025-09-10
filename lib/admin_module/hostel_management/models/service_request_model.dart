import 'package:equatable/equatable.dart';

enum RequestTypes { product, service }
enum RequestPrioritys { low, medium, high }
enum RequestStatus { pending, approved, resolved, completed, // 'Resolved' from screenshot for an 'Approved' item
  cancelled } // Adding cancelled for completeness

class ServiceRequestItems extends Equatable {
  final String id;
  final DateTime date;
  final RequestTypes type;
  final String? productName; // For product requests
  final int? quantity; // For product requests
  final String? serviceType; // For service requests (e.g., Electrician, Plumber)
  final RequestPrioritys priority;
  final String? comment;
  final RequestStatus status;
  final String? actionComment; // Comment added by admin when taking action

  const ServiceRequestItems({
    required this.id,
    required this.date,
    required this.type,
    this.productName,
    this.quantity,
    this.serviceType,
    required this.priority,
    this.comment,
    required this.status,
    this.actionComment,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    type,
    productName,
    quantity,
    serviceType,
    priority,
    comment,
    status,
    actionComment,
  ];

  ServiceRequestItems copyWith({
    String? id,
    DateTime? date,
    RequestTypes? type,
    String? productName,
    int? quantity,
    String? serviceType,
    RequestPrioritys? priority,
    String? comment,
    RequestStatus? status,
    String? actionComment,
  }) {
    return ServiceRequestItems(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      serviceType: serviceType ?? this.serviceType,
      priority: priority ?? this.priority,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      actionComment: actionComment ?? this.actionComment,
    );
  }
}