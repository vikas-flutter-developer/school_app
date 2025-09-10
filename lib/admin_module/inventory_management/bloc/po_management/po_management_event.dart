part of 'po_management_bloc.dart';

abstract class PoManagementEvent extends Equatable {
  const PoManagementEvent();
  @override
  List<Object?> get props => [];
}

class LoadPurchaseOrders extends PoManagementEvent {}

class LoadBills extends PoManagementEvent {}

class AddNewPurchaseOrder extends PoManagementEvent {
  final PurchaseOrderModel purchaseOrder;
  const AddNewPurchaseOrder(this.purchaseOrder);
  @override
  List<Object?> get props => [purchaseOrder];
}

// For the PO Creation Form
class UpdatePoFormField extends PoManagementEvent {
  final String fieldName;
  final dynamic value;
  const UpdatePoFormField(this.fieldName, this.value);
  @override
  List<Object?> get props => [fieldName, value];
}

class AddItemToPo extends PoManagementEvent {
  final POItemModel item;
  const AddItemToPo(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveItemFromPo extends PoManagementEvent {
  final String itemId;
  const RemoveItemFromPo(this.itemId);
  @override
  List<Object?> get props => [itemId];
}

class ResetPoForm extends PoManagementEvent {}
