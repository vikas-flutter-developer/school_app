import 'package:equatable/equatable.dart';

enum BillStatus { pending, paid, overdue }

class BillModel extends Equatable {
  final String id;
  final String billNo;
  final double amount;
  final DateTime billDate;
  final DateTime dueDate;
  final BillStatus status;

  const BillModel({
    required this.id,
    required this.billNo,
    required this.amount,
    required this.billDate,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object?> get props => [id, billNo, amount, billDate, dueDate, status];
}
