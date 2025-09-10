import '../../models/service_request.dart';

abstract class ServiceRequestRepository {
  Future<List<ServiceRequest>> getServiceRequests();
  Future<void> submitServiceRequest(Map<String, dynamic> formData);
  // Add other methods like update, cancel if needed
}
