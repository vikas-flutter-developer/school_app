import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/services/bloc/services_event.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/services/bloc/services_state.dart';
import '../../../models/service_request_model.dart';

class ServiceRequestsBloc extends Bloc<ServiceRequestEvent, ServiceRequestState> {
  final List<ServiceRequestItems> _mockServiceRequests = [
    ServiceRequestItems(
      id: 'sr001', // Corresponds to 2025 2536 78
      date: DateTime(2025, 4, 3),
      type: RequestTypes.product,
      productName: 'Fan',
      quantity: 3,
      serviceType: 'Electrician', // This seems to be fixed even for product
      priority: RequestPrioritys.high,
      comment: 'The fans will be ordered today and get delivered in 3-4 days. You can contact electrician Sudhir Jain - 98657 67584',
      status: RequestStatus.pending,
    ),
    ServiceRequestItems(
      id: 'sr002',
      date: DateTime(2025, 4, 3),
      type: RequestTypes.product,
      productName: 'Fan',
      quantity: 3,
      serviceType: 'Electrician',
      priority: RequestPrioritys.high,
      status: RequestStatus.approved,
      // actionComment for "Resolved: Contacted MSEB" would be added on update
    ),
    ServiceRequestItems(
      id: 'sr003',
      date: DateTime(2025, 4, 3),
      type: RequestTypes.product,
      productName: 'Fan',
      quantity: 3,
      serviceType: 'Electrician',
      priority: RequestPrioritys.high,
      comment: 'The fans will be ordered today and get delivered in 3-4 days. You can contact electrician Sudhir Jain - 98657 67584',
      status: RequestStatus.completed,
    ),
  ];


  ServiceRequestsBloc() : super(ServiceRequestInitial()) {
    on<LoadServiceRequests>(_onLoadServiceRequests);
    on<SubmitServiceRequest>(_onSubmitServiceRequest);
    on<UpdateServiceRequestStatus>(_onUpdateServiceRequestStatus);
  }

  Future<void> _onLoadServiceRequests(
      LoadServiceRequests event,
      Emitter<ServiceRequestState> emit,
      ) async {
    emit(ServiceRequestLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ServiceRequestListLoadSuccess(List.from(_mockServiceRequests)));
  }

  Future<void> _onSubmitServiceRequest(
      SubmitServiceRequest event,
      Emitter<ServiceRequestState> emit,
      ) async {
    emit(ServiceRequestLoading());
    await Future.delayed(const Duration(seconds: 1));
    final newRequest = ServiceRequestItems(
      id: 'sr${_mockServiceRequests.length + 1}',
      date: DateTime.now(),
      type: event.type,
      productName: event.productName,
      quantity: event.quantity,
      serviceType: event.serviceType,
      priority: event.priority,
      comment: event.comment,
      status: RequestStatus.pending,
    );
    _mockServiceRequests.insert(0, newRequest);
    emit(const ServiceRequestSubmissionSuccess('Service request submitted.'));
    add(LoadServiceRequests());
  }

  Future<void> _onUpdateServiceRequestStatus(
      UpdateServiceRequestStatus event,
      Emitter<ServiceRequestState> emit,
      ) async {
    emit(ServiceRequestLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    int index = _mockServiceRequests.indexWhere((req) => req.id == event.requestId);
    if (index != -1) {
      _mockServiceRequests[index] = _mockServiceRequests[index].copyWith(
        status: event.newStatus,
        actionComment: event.actionComment ?? _mockServiceRequests[index].actionComment,
      );
      emit(ServiceRequestUpdateSuccess('Request status updated to ${event.newStatus.name}.'));
      add(LoadServiceRequests());
    } else {
      emit(const ServiceRequestError('Request not found.'));
    }
  }
}