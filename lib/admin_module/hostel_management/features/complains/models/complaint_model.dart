import 'package:equatable/equatable.dart';

class ComplaintModel extends Equatable {
  final String id;
  final String subject;
  final String status;
  final String action;
  final String date;

  const ComplaintModel({
    required this.id,
    required this.subject,
    required this.status,
    required this.action,
    required this.date,
  });

  factory ComplaintModel.fromMap(Map<String, String> map) {
    return ComplaintModel(
      id: map['id'] ?? '',
      subject: map['subject'] ?? '',
      status: map['status'] ?? '',
      action: map['action'] ?? '',
      date: map['date'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'subject': subject,
      'status': status,
      'action': action,
      'date': date,
    };
  }

  @override
  List<Object?> get props => [id, subject, status, action, date];
}

// Sample data (can be moved to a repository or service later)
final List<Map<String, String>> rawComplaintsData = [
  {
    'id': 'A5 1235 8887 4646',
    'subject': 'Daily power-cut issues',
    'status': 'Pending',
    'action': 'Contacted MSEB',
    'date': '04/03/2025',
  },
  {
    'id': 'B6 9876 5432 1011',
    'subject': 'Water leakage in Room 202',
    'status': 'Resolved',
    'action': 'Plumber on the way',
    'date': '04/03/2025',
  },
  {
    'id': 'C7 2468 1357 9123',
    'subject': 'Internet connectivity problems',
    'status': 'Cancelled',
    'action': 'Technician visited',
    'date': '03/03/2025',
  },
  {
    'id': 'D8 1122 3344 5566',
    'subject': 'Noisy соседи', // Assuming this Cyrillic text is intentional
    'status': 'Pending',
    'action': 'Warning issued',
    'date': '02/03/2025',
  },
  {
    'id': 'E9 2233 4455 6677',
    'subject': 'Broken Chair',
    'status': 'Resolved',
    'action': 'Replaced',
    'date': '01/03/2025',
  },
  {
    'id': 'F1 3344 5566 7788',
    'subject': 'Leaky Roof',
    'status': 'Cancelled',
    'action': 'Repairs Postponed',
    'date': '28/02/2025',
  },
];

final List<ComplaintModel> sampleComplaints =
    rawComplaintsData.map((data) => ComplaintModel.fromMap(data)).toList();
