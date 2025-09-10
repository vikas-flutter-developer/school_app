import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/service_request.dart';

part 'service_request_list_state.dart';

class ServiceRequestListCubit extends Cubit<ServiceRequestListState> {
  List<ServiceRequest> _allRequests =
      []; // Store the full list for filtering/searching

  ServiceRequestListCubit() : super(ServiceRequestListInitial());

  // In real app: Inject Repository
  // final ServiceRequestRepository _repository;
  // ServiceRequestListCubit(this._repository) : super(ServiceRequestListInitial());

  Future<void> fetchRequests() async {
    try {
      emit(ServiceRequestListLoading());
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Replace with actual data fetching: _allRequests = await _repository.getRequests();
      _allRequests = ServiceRequest.generateMockServiceRequests();

      emit(ServiceRequestListLoaded(_allRequests));
    } catch (e) {
      emit(
        ServiceRequestListError(
          'Failed to load service requests: ${e.toString()}',
        ),
      );
    }
  }

  void searchRequests(String searchTerm) {
    if (state is ServiceRequestListLoaded ||
        state is ServiceRequestListLoading ||
        state is ServiceRequestListInitial) {
      // Allow search even while loading initial data perhaps?
      final lowerCaseSearchTerm = searchTerm.toLowerCase().trim();

      if (lowerCaseSearchTerm.isEmpty) {
        // If search is cleared, show all results
        emit(ServiceRequestListLoaded(_allRequests, searchTerm: null));
        return;
      }

      final filteredRequests =
          _allRequests.where((req) {
            final productNameMatch =
                req.productName?.toLowerCase().contains(lowerCaseSearchTerm) ??
                false;
            final serviceTypeMatch =
                req.serviceType?.toLowerCase().contains(lowerCaseSearchTerm) ??
                false;
            final commentMatch = req.comment.toLowerCase().contains(
              lowerCaseSearchTerm,
            );
            final idMatch = req.formattedId.toLowerCase().contains(
              lowerCaseSearchTerm,
            ); // Search formatted ID

            return productNameMatch ||
                serviceTypeMatch ||
                commentMatch ||
                idMatch;
          }).toList();

      // Keep track of the search term in the state
      emit(ServiceRequestListLoaded(filteredRequests, searchTerm: searchTerm));
    }
  }

  // Add filter logic (by status, type, priority) if the filter button is implemented
  void filterRequests(/* Add parameters like status, type, priority */) {
    if (state is ServiceRequestListLoaded) {
      // Implement filtering logic similar to search or ticket list filter
      // Example: filter by status
      // final filtered = _allRequests.where((req) => req.status == targetStatus).toList();
      // emit(ServiceRequestListLoaded(filtered));
    }
  }
}
