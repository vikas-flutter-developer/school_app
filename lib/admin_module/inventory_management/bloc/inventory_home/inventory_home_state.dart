part of 'inventory_home_bloc.dart';

enum InventoryHomeStatus { initial, loading, success, failure }

class InventoryHomeState extends Equatable {
  final InventoryHomeStatus status;
  final List<InventoryRequestModel> requests;
  final String? errorMessage;

  const InventoryHomeState({
    this.status = InventoryHomeStatus.initial,
    this.requests = const [],
    this.errorMessage,
  });

  InventoryHomeState copyWith({
    InventoryHomeStatus? status,
    List<InventoryRequestModel>? requests,
    String? errorMessage,
  }) {
    return InventoryHomeState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage];
}
