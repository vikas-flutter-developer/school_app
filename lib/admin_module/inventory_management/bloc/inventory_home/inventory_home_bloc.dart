import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/inventory_request_model.dart';
import '../../data/repo/inventory_repository.dart';

part 'inventory_home_event.dart';
part 'inventory_home_state.dart';

class InventoryHomeBloc extends Bloc<InventoryHomeEvent, InventoryHomeState> {
  final InventoryRepository inventoryRepository;

  InventoryHomeBloc({required this.inventoryRepository})
    : super(const InventoryHomeState()) {
    on<LoadInventoryHomeData>(_onLoadInventoryHomeData);
    on<ApproveRequest>(_onApproveRequest);
  }

  Future<void> _onLoadInventoryHomeData(
    LoadInventoryHomeData event,
    Emitter<InventoryHomeState> emit,
  ) async {
    emit(state.copyWith(status: InventoryHomeStatus.loading));
    try {
      final requests = await inventoryRepository.getInventoryRequests();
      emit(
        state.copyWith(status: InventoryHomeStatus.success, requests: requests),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: InventoryHomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onApproveRequest(
    ApproveRequest event,
    Emitter<InventoryHomeState> emit,
  ) async {
    // Optionally show loading on the specific item or overall
    try {
      await inventoryRepository.approveInventoryRequest(event.requestId);
      // Reload data or update locally
      final updatedRequests =
          state.requests.map((req) {
            if (req.id == event.requestId) {
              return req.copyWith(status: RequestStatus.approved);
            }
            return req;
          }).toList();
      emit(state.copyWith(requests: updatedRequests));
    } catch (e) {
      // Handle error, maybe emit a failure state for this specific action
      emit(
        state.copyWith(
          status: InventoryHomeStatus.failure,
          errorMessage: 'Failed to approve: ${e.toString()}',
        ),
      );
      add(LoadInventoryHomeData()); // Reload to ensure consistency
    }
  }
}
