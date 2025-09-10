import 'package:equatable/equatable.dart';

enum POStatus { pending, approved, processing, shipped, delivered, cancelled }

class PurchaseOrderModel extends Equatable {
  final String id; // Unique ID for the PO
  final String poNumber;
  final String createdNumber; // Could be internal ref
  final String vendorName;
  final POStatus status;
  final double amount;
  // Details for creation form
  final String? account;
  final String? deliverTo;
  final String? emailId;
  final String? mobileNumber;
  final String? orderNo; // This might be same as poNumber or different
  final DateTime? creationDate;
  final DateTime? expectedDeliveryDate;
  final String? notes;
  final List<POItemModel> items;

  const PurchaseOrderModel({
    required this.id,
    required this.poNumber,
    required this.createdNumber,
    required this.vendorName,
    required this.status,
    required this.amount,
    this.account,
    this.deliverTo,
    this.emailId,
    this.mobileNumber,
    this.orderNo,
    this.creationDate,
    this.expectedDeliveryDate,
    this.notes,
    this.items = const [],
  });

  @override
  List<Object?> get props => [
    id,
    poNumber,
    createdNumber,
    vendorName,
    status,
    amount,
    account,
    deliverTo,
    emailId,
    mobileNumber,
    orderNo,
    creationDate,
    expectedDeliveryDate,
    notes,
    items,
  ];

  PurchaseOrderModel copyWith({
    String? id,
    String? poNumber,
    String? createdNumber,
    String? vendorName,
    POStatus? status,
    double? amount,
    String? account,
    String? deliverTo,
    String? emailId,
    String? mobileNumber,
    String? orderNo,
    DateTime? creationDate,
    DateTime? expectedDeliveryDate,
    String? notes,
    List<POItemModel>? items,
  }) {
    return PurchaseOrderModel(
      id: id ?? this.id,
      poNumber: poNumber ?? this.poNumber,
      createdNumber: createdNumber ?? this.createdNumber,
      vendorName: vendorName ?? this.vendorName,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      account: account ?? this.account,
      deliverTo: deliverTo ?? this.deliverTo,
      emailId: emailId ?? this.emailId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      orderNo: orderNo ?? this.orderNo,
      creationDate: creationDate ?? this.creationDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      notes: notes ?? this.notes,
      items: items ?? this.items,
    );
  }
}

class POItemModel extends Equatable {
  final String id; // Unique ID for item, can be temp for client-side
  final String itemDetails;
  final String? comments;
  final int quantity;
  final double costPerUnit;
  final double amount;

  const POItemModel({
    required this.id,
    required this.itemDetails,
    this.comments,
    required this.quantity,
    required this.costPerUnit,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    id,
    itemDetails,
    comments,
    quantity,
    costPerUnit,
    amount,
  ];
}
