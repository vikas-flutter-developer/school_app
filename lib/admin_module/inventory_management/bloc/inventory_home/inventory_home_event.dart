part of 'inventory_home_bloc.dart';

abstract class InventoryHomeEvent extends Equatable {
  const InventoryHomeEvent();
  @override
  List<Object> get props => [];
}

class LoadInventoryHomeData extends InventoryHomeEvent {}

class ApproveRequest extends InventoryHomeEvent {
  final String requestId;
  const ApproveRequest(this.requestId);
  @override
  List<Object> get props => [requestId];
}
