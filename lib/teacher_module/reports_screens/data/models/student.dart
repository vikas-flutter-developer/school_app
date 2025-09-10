// lib/data/models/student.dart
import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String name;
  final String? photoUrl; // Make nullable if photo might be missing
  final int? rank; // Make nullable if rank might be missing
  final String className;
  final String rollNo;
  final String academicYear;
  final String admissionNumber;
  final DateTime dateOfAdmission;

  const Student({
    required this.id,
    required this.name,
    this.photoUrl,
    this.rank,
    required this.className,
    required this.rollNo,
    required this.academicYear,
    required this.admissionNumber,
    required this.dateOfAdmission,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    photoUrl,
    rank,
    className,
    rollNo,
    academicYear,
    admissionNumber,
    dateOfAdmission,
  ];
}

// Add models for Topper, PerformanceDataPoint etc. as needed
