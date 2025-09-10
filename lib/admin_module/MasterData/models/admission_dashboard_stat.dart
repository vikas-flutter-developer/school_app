// models/admission_dashboard_stat.dart
import 'package:equatable/equatable.dart';

class AdmissionDashboardStat extends Equatable {
  final String count;
  final String label;

  const AdmissionDashboardStat({required this.count, required this.label});

  @override List<Object?> get props => [count, label];
}

// Dummy data
const List<AdmissionDashboardStat> dummyAdmissionStats = [
  AdmissionDashboardStat(count: '20', label: 'Overview'),
  AdmissionDashboardStat(count: '20', label: 'Enquiry'),
  AdmissionDashboardStat(count: '20', label: 'Application form isssued'), // Typo corrected if needed
  AdmissionDashboardStat(count: '20', label: 'Interview'),
  AdmissionDashboardStat(count: '20', label: 'Exam'),
];