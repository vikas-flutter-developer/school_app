import 'package:equatable/equatable.dart';

enum VisitorStatus { newRequest, pending, approved, denied }

class VisitorPass extends Equatable {
  final String id;
  final DateTime date;
  final String visitorName;
  final String studentName;
  final String studentClass; // e.g., "VII B"
  final String relation; // e.g., "Father"
  final String purpose; // e.g., "Casual"
  final int visitNumber;
  final String? inTime; // e.g., "03:00pm"
  final String? outTime; // e.g., "00:00pm" (or null if not checked out)
  final String? reasonForVisit; // Could be same as purpose or more detailed
  final VisitorStatus status;

  const VisitorPass({
    required this.id,
    required this.date,
    required this.visitorName,
    required this.studentName,
    required this.studentClass,
    required this.relation,
    required this.purpose,
    required this.visitNumber,
    this.inTime,
    this.outTime,
    this.reasonForVisit,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    visitorName,
    studentName,
    studentClass,
    relation,
    purpose,
    visitNumber,
    inTime,
    outTime,
    reasonForVisit,
    status,
  ];

  VisitorPass copyWith({
    String? id,
    DateTime? date,
    String? visitorName,
    String? studentName,
    String? studentClass,
    String? relation,
    String? purpose,
    int? visitNumber,
    String? inTime,
    String? outTime,
    String? reasonForVisit,
    VisitorStatus? status,
  }) {
    return VisitorPass(
      id: id ?? this.id,
      date: date ?? this.date,
      visitorName: visitorName ?? this.visitorName,
      studentName: studentName ?? this.studentName,
      studentClass: studentClass ?? this.studentClass,
      relation: relation ?? this.relation,
      purpose: purpose ?? this.purpose,
      visitNumber: visitNumber ?? this.visitNumber,
      inTime: inTime ?? this.inTime,
      outTime: outTime ?? this.outTime,
      reasonForVisit: reasonForVisit ?? this.reasonForVisit,
      status: status ?? this.status,
    );
  }
}