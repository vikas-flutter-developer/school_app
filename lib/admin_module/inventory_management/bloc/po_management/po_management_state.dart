part of 'po_management_bloc.dart';

enum PoManagementStatus { initial, loading, success, failure }

enum PoCreationStatus { initial, editing, submitting, success, failure }

class PoManagementState extends Equatable {
  // For PO List and Bill List
  final PoManagementStatus poListStatus;
  final List<PurchaseOrderModel> purchaseOrders;
  final String? poListErrorMessage;

  final PoManagementStatus billListStatus;
  final List<BillModel> bills;
  final String? billListErrorMessage;

  // For PO Creation Form
  final PoCreationStatus poCreationStatus;
  final PurchaseOrderModel currentPoDraft; // Holds the PO being created/edited
  final String? poCreationErrorMessage;

  const PoManagementState({
    this.poListStatus = PoManagementStatus.initial,
    this.purchaseOrders = const [],
    this.poListErrorMessage,
    this.billListStatus = PoManagementStatus.initial,
    this.bills = const [],
    this.billListErrorMessage,
    this.poCreationStatus = PoCreationStatus.initial,
    this.currentPoDraft = const PurchaseOrderModel(
      // Initial empty draft
      id: '',
      poNumber: '',
      createdNumber: '',
      vendorName: '',
      status: POStatus.pending,
      amount: 0.0,
    ),
    this.poCreationErrorMessage,
  });

  PoManagementState copyWith({
    PoManagementStatus? poListStatus,
    List<PurchaseOrderModel>? purchaseOrders,
    String? poListErrorMessage,
    PoManagementStatus? billListStatus,
    List<BillModel>? bills,
    String? billListErrorMessage,
    PoCreationStatus? poCreationStatus,
    PurchaseOrderModel? currentPoDraft,
    String? poCreationErrorMessage,
  }) {
    return PoManagementState(
      poListStatus: poListStatus ?? this.poListStatus,
      purchaseOrders: purchaseOrders ?? this.purchaseOrders,
      poListErrorMessage: poListErrorMessage ?? this.poListErrorMessage,
      billListStatus: billListStatus ?? this.billListStatus,
      bills: bills ?? this.bills,
      billListErrorMessage: billListErrorMessage ?? this.billListErrorMessage,
      poCreationStatus: poCreationStatus ?? this.poCreationStatus,
      currentPoDraft: currentPoDraft ?? this.currentPoDraft,
      poCreationErrorMessage:
          poCreationErrorMessage ?? this.poCreationErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    poListStatus,
    purchaseOrders,
    poListErrorMessage,
    billListStatus,
    bills,
    billListErrorMessage,
    poCreationStatus,
    currentPoDraft,
    poCreationErrorMessage,
  ];
}
