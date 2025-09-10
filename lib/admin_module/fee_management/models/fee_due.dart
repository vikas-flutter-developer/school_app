// models/fee_due.dart
import 'package:equatable/equatable.dart';

class FeeDue extends Equatable {
  final String studentName;
  final String pendingFees; // Keep as string with currency
  final String dueDate;

  const FeeDue({
    required this.studentName,
    required this.pendingFees,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [studentName, pendingFees, dueDate];
}

// Dummy Data for Fees Due
const List<FeeDue> dummyFeeDues = [
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
  FeeDue(studentName: 'Naveen Naveen', pendingFees: '₹ 25,000', dueDate: 'March 20, 2025'),
];