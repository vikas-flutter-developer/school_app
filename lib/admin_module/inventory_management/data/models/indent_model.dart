import 'package:equatable/equatable.dart';

enum IndentStatus { pending, active, inactive }

class IndentModel extends Equatable {
  final String srNo;
  final String indentNo;
  final DateTime date;
  final String title;
  final String raisedBy;
  final String department;
  final IndentStatus status;
  final String? storeRequested; // For AddIndentDialog
  final String? productDetails; // For AddIndentDialog
  final String? remarks; // For AddIndentDialog

  const IndentModel({
    required this.srNo,
    required this.indentNo,
    required this.date,
    required this.title,
    required this.raisedBy,
    required this.department,
    required this.status,
    this.storeRequested,
    this.productDetails,
    this.remarks,
  });

  @override
  List<Object?> get props => [
    srNo,
    indentNo,
    date,
    title,
    raisedBy,
    department,
    status,
    storeRequested,
    productDetails,
    remarks,
  ];

  IndentModel copyWith({
    String? srNo,
    String? indentNo,
    DateTime? date,
    String? title,
    String? raisedBy,
    String? department,
    IndentStatus? status,
    String? storeRequested,
    String? productDetails,
    String? remarks,
  }) {
    return IndentModel(
      srNo: srNo ?? this.srNo,
      indentNo: indentNo ?? this.indentNo,
      date: date ?? this.date,
      title: title ?? this.title,
      raisedBy: raisedBy ?? this.raisedBy,
      department: department ?? this.department,
      status: status ?? this.status,
      storeRequested: storeRequested ?? this.storeRequested,
      productDetails: productDetails ?? this.productDetails,
      remarks: remarks ?? this.remarks,
    );
  }
}
