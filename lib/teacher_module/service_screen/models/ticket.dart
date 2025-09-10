import 'package:equatable/equatable.dart';

import '../features/common_widgets/status_chip.dart'; // Import Status enum

class Ticket extends Equatable {
  final String id;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime submittedDate;
  final String raisedBy; // Could be a User object later
  final TicketStatus status;
  final String? approvalFrom; // e.g., "Management"
  final String? rejectionFrom; // e.g., "Management"
  final String reason; // Only for raise ticket form

  const Ticket({
    required this.id,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.submittedDate,
    required this.raisedBy,
    required this.status,
    this.approvalFrom,
    this.rejectionFrom,
    required this.reason,
  });

  @override
  List<Object?> get props => [
    id,
    category,
    startDate,
    endDate,
    submittedDate,
    raisedBy,
    status,
    approvalFrom,
    rejectionFrom,
    reason,
  ];

  // Mock Data Generator
  static List<Ticket> generateMockTickets() {
    final now = DateTime.now();
    return [
      Ticket(
        id: 'TKT12345',
        category: 'Transfer',
        startDate: now.add(const Duration(days: 1)),
        endDate: now.add(
          const Duration(days: 2, hours: 17),
        ), // Jan 21 - Jan 22, 2025 (adjust year if needed)
        submittedDate: now.subtract(
          const Duration(hours: 2),
        ), // Jan 20, 7:40 pm (adjust)
        raisedBy:
            'Anita Kapoor (Self)', // Assume user raises for self initially
        status: TicketStatus.Pending,
        approvalFrom: 'Management',
        reason: 'Requesting transfer to another branch for personal reasons.',
      ),
      Ticket(
        id: 'TKT67890',
        category: 'Transfer',
        startDate: now.add(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 2, hours: 17)),
        submittedDate: now.subtract(const Duration(hours: 2)),
        raisedBy: 'John Doe',
        status: TicketStatus.Approved,
        approvalFrom: 'Management',
        reason: 'Approved transfer request.',
      ),
      Ticket(
        id: 'TKT11223',
        category: 'Resignation',
        startDate: now.add(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 2, hours: 17)),
        submittedDate: now.subtract(const Duration(hours: 2)),
        raisedBy: 'Jane Smith',
        status: TicketStatus.Rejected,
        rejectionFrom: 'Management',
        reason: 'Policy violation.',
      ),
      Ticket(
        id: 'TKT44556',
        category: 'Transfer',
        startDate: now.add(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 2, hours: 17)),
        submittedDate: now.subtract(const Duration(hours: 2)),
        raisedBy: 'Peter Jones',
        status: TicketStatus.Rejected,
        rejectionFrom: 'HR Department',
        reason: 'Position not available.',
      ),
    ];
  }
}

const List<String> ticketCategories = [
  'Transfer',
  'Resignation',
  'Leave',
  'Complaint',
  'Other',
];
