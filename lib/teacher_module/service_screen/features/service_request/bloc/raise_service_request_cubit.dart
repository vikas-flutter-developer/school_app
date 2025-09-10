import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/service_request.dart';
import '../../common_widgets/status_chip.dart';
import 'package:uuid/uuid.dart';
part 'raise_service_request_state.dart';

class RaiseServiceRequestCubit extends Cubit<RaiseServiceRequestState> {
  RaiseServiceRequestCubit() : super(RaiseServiceRequestInitial());

  // Inject repository in real app
  // final ServiceRequestRepository _repository;
  // RaiseServiceRequestCubit(this._repository) : super(RaiseServiceRequestInitial());

  Future<void> submitRequest({
    required RequestType requestType,
    String? productName,
    int? quantity,
    String? serviceType,
    RequestPriority? priority,
    required String comment,
    // Optional: Pass these if frontend generates them
    // String? generatedId,
    // DateTime? requestDate,
  }) async {
    try {
      emit(RaiseServiceRequestSubmitting());

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Create the request object - backend should ideally generate ID and date
      final newRequest = ServiceRequest(
        id: '${DateTime.now().year}${Uuid().v4().substring(0, 8).replaceAll('-', '')}'
            .substring(0, 10), // Mock ID generation
        requestDate: DateTime.now(), // Mock request date
        requestType: requestType,
        status: ServiceRequestStatus.Pending, // Default status
        productName: productName,
        quantity: quantity,
        serviceType: serviceType,
        priority: priority,
        comment: comment,
      );

      // In real app: await _repository.createServiceRequest(newRequest);
      print('Submitting Service Request: ${newRequest.formattedId}');
      print('Details: ${newRequest.toString()}');

      emit(RaiseServiceRequestSuccess());
    } catch (e) {
      emit(
        RaiseServiceRequestFailure('Failed to submit request: ${e.toString()}'),
      );
    }
  }
}
