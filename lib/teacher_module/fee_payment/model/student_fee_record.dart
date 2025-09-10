import 'package:flutter/material.dart';

enum FeeStatus { Paid, Unpaid, Overdue }

class StudentFeeRecord {
  final String name;
  final String rollNo;
  final String term;
  final FeeStatus status;
  final double amountDue;

  StudentFeeRecord({
    required this.name,
    required this.rollNo,
    required this.term,
    required this.status,
    required this.amountDue,
  });

  // Helper to get color based on status
  Color get statusColor {
    switch (status) {
      case FeeStatus.Paid:
        return Colors.green;
      case FeeStatus.Unpaid:
        return Colors.orange;
      case FeeStatus.Overdue:
        return Colors.red;
    }
  }

  // Helper to get text representation of status
  String get statusText {
    switch (status) {
      case FeeStatus.Paid:
        return "Paid";
      case FeeStatus.Unpaid:
        return "Unpaid";
      case FeeStatus.Overdue:
        return "Overdue";
    }
  }
}

// Mock Data Generation (Replace with actual data fetching)
List<StudentFeeRecord> generateMockStudentData() {
  return List.generate(40, (index) {
    FeeStatus status;
    double amountDue;
    if (index % 5 == 3) {
      status = FeeStatus.Overdue;
      amountDue = 5000.0;
    } else if (index % 5 == 4) {
      status = FeeStatus.Unpaid;
      amountDue = (index + 1) * 1000.0;
    } else {
      status = FeeStatus.Paid;
      amountDue = 0.0;
    }
    return StudentFeeRecord(
      name: "Ansh Gupta ${index + 1}", // Make names slightly different
      rollNo: (101 + index).toString(),
      term: "Term- I", // Keep term same for initial filter example
      status: status,
      amountDue: amountDue,
    );
  });
}
