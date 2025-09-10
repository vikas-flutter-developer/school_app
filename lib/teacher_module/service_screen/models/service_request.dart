// import 'package:equatable/equatable.dart';
// import 'enums.dart'; // Assuming enums.dart contains your enum definitions
//
// class ServiceRequest extends Equatable {
//   final String id;
//   final DateTime requestDate;
//   final String productName;
//   final int quantity;
//   final ServiceType? serviceType; // Nullable if it's a product request?
//   final Priority priority;
//   final String comment;
//   final RequestStatus status;
//   final String? contactInfo; // e.g., for electrician details
//
//   const ServiceRequest({
//     required this.id,
//     required this.requestDate,
//     required this.productName,
//     required this.quantity,
//     this.serviceType, // Keep nullable in constructor if it makes sense
//     required this.priority,
//     required this.comment,
//     required this.status,
//     this.contactInfo,
//   });
//
//   @override
//   List<Object?> get props => [
//     id,
//     requestDate,
//     productName,
//     quantity,
//     serviceType,
//     priority,
//     comment,
//     status,
//     contactInfo,
//   ];
//
//   // Creates a new ServiceRequest instance with updated fields.
//   // Fields not provided will retain their current values.
//   ServiceRequest copyWith({
//     String? id,
//     DateTime? requestDate,
//     String? productName,
//     int? quantity,
//     // Handling nullable fields: Use a helper or specific logic if you need
//     // to explicitly set serviceType to null. For simplicity, this assumes
//     // if you provide 'null' it means 'no change'. If you need to set it TO null,
//     // you might need a different approach (like using a wrapper class).
//     // However, the common pattern is that null means 'no change'.
//     ServiceType? serviceType,
//     Priority? priority,
//     String? comment,
//     RequestStatus? status,
//     String? contactInfo, // Allow setting contactInfo
//     bool clearContactInfo =
//         false, // Optional: Add flag to explicitly clear nullable fields
//     bool clearServiceType =
//         false, // Optional: Add flag to explicitly clear nullable fields
//   }) {
//     return ServiceRequest(
//       // Use the provided value if it's not null, otherwise use the current value.
//       id: id ?? this.id,
//       requestDate: requestDate ?? this.requestDate,
//       productName: productName ?? this.productName,
//       quantity: quantity ?? this.quantity,
//       // If clearServiceType is true, set to null.
//       // Otherwise, use the provided serviceType or the current one.
//       serviceType: clearServiceType ? null : serviceType ?? this.serviceType,
//       priority: priority ?? this.priority,
//       comment: comment ?? this.comment,
//       status: status ?? this.status,
//       // If clearContactInfo is true, set to null.
//       // Otherwise, use the provided contactInfo or the current one.
//       contactInfo: clearContactInfo ? null : contactInfo ?? this.contactInfo,
//     );
//   }
// }
//
// // --- Example Usage ---
//
// void example() {
//   final initialRequest = ServiceRequest(
//     id: '123',
//     requestDate: DateTime.now(),
//     productName: 'Laptop',
//     quantity: 1,
//     serviceType: ServiceType.it,
//     priority: Priority.high,
//     comment: 'Needs setup',
//     status: RequestStatus.pending,
//     contactInfo: 'Tech support: 555-1234',
//   );
//
//   // Update only the status
//   final updatedRequest = initialRequest.copyWith(
//     status: RequestStatus.approved,
//   );
//   print(updatedRequest.status); // Output: RequestStatus.approved
//   print(updatedRequest.productName); // Output: Laptop (unchanged)
//
//   // Update quantity and comment
//   final modifiedRequest = initialRequest.copyWith(
//     quantity: 2,
//     comment: 'Needs setup for two users',
//   );
//   print(modifiedRequest.quantity); // Output: 2
//   print(modifiedRequest.comment); // Output: Needs setup for two users
//
//   // Update and explicitly clear contactInfo
//   final clearedContactRequest = initialRequest.copyWith(
//     status: RequestStatus.completed,
//     clearContactInfo: true,
//   );
//   print(clearedContactRequest.status); // Output: RequestStatus.completed
//   print(clearedContactRequest.contactInfo); // Output: null
// }
//
// // You would need these enums defined in 'enums.dart' or here
// // enum ServiceType { electrician, plumbing, it, general }
// // enum Priority { low, medium, high }
// // enum RequestStatus { pending, approved, rejected, completed }
import 'package:equatable/equatable.dart';

import '../features/common_widgets/status_chip.dart';

// Enums specific to Service Requests
enum RequestType { Product, Service }

enum RequestPriority { Low, Medium, High }

// Re-using the status enum, ensure it covers all needed states
// enum ServiceRequestStatus { Pending, Approved, Rejected } // Already in StatusChip

class ServiceRequest extends Equatable {
  final String id; // e.g., 2025 2536 78
  final DateTime requestDate;
  final RequestType requestType;
  final ServiceRequestStatus status; // Use the common enum
  final String? productName;
  final int? quantity;
  final String? serviceType; // e.g., Electrician, Plumber
  final RequestPriority? priority;
  final String comment;

  const ServiceRequest({
    required this.id,
    required this.requestDate,
    required this.requestType,
    required this.status,
    this.productName,
    this.quantity,
    this.serviceType,
    this.priority,
    required this.comment,
  });

  // Helper to format ID
  String get formattedId {
    if (id.length >= 10) {
      // Basic check for format like YYYY XXXX XX
      return '${id.substring(0, 4)} ${id.substring(4, 8)} ${id.substring(8)}';
    }
    return id; // Return as is if not matching format
  }

  @override
  List<Object?> get props => [
    id,
    requestDate,
    requestType,
    status,
    productName,
    quantity,
    serviceType,
    priority,
    comment,
  ];

  // Mock Data Generator
  static List<ServiceRequest> generateMockServiceRequests() {
    final now = DateTime.now();

    return [
      ServiceRequest(
        id: '2025253678', // Example ID
        requestDate: DateTime(2025, 3, 4), // Specific date from screenshot
        requestType: RequestType.Product,
        status: ServiceRequestStatus.Pending,
        productName: 'Chalk',
        quantity: 3,
        serviceType: null, // N/A for Product
        priority:
            RequestPriority.High, // Priority still relevant? Design shows it
        comment: 'Required Colour chalks',
      ),
      ServiceRequest(
        id: '2025253679', // Different ID
        requestDate: DateTime(2025, 3, 4), // Specific date from screenshot
        requestType: RequestType.Service,
        status: ServiceRequestStatus.Approved,
        productName:
            'Projector', // Sometimes product name is relevant for service too?
        quantity: 1, // Clarify if quantity applies to service request
        serviceType: 'Electrician',
        priority: RequestPriority.High,
        comment: 'Projector installation needed urgently.',
      ),
      ServiceRequest(
        id: '2025253680',
        requestDate: now.subtract(const Duration(days: 1)),
        requestType: RequestType.Product,
        status: ServiceRequestStatus.Rejected,
        productName: 'Whiteboard Markers',
        quantity: 10,
        priority: RequestPriority.Medium,
        comment: 'Budget exceeded for this quarter.',
      ),
      ServiceRequest(
        id: '2025253681',
        requestDate: now.subtract(const Duration(hours: 5)),
        requestType: RequestType.Service,
        status: ServiceRequestStatus.Pending,
        serviceType: 'Plumber',
        priority: RequestPriority.Low,
        comment: 'Leaking faucet in staff room.',
      ),
    ];
  }
}

// For dropdowns in the form
const List<String> serviceTypes = [
  'Electrician',
  'Plumber',
  'Carpenter',
  'IT Support',
  'Cleaning',
];
const List<RequestPriority> priorities =
    RequestPriority.values; // Use the enum values directly
