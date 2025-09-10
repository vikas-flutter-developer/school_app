enum RequestStatus { pending, approved, rejected, completed }

enum Priority { low, medium, high }

enum ServiceType { electrician, plumbing, it, general } // Add more as needed

enum TicketCategory { transfer, resignation, leave, general } // Add more

// Helper extension for display names or colors
extension RequestStatusX on RequestStatus {
  String get displayName {
    switch (this) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.approved:
        return 'Approved';
      case RequestStatus.rejected:
        return 'Rejected';
      case RequestStatus.completed:
        return 'Completed';
    }
  }

  // Add color mapping if needed
}

// Similar extensions for Priority, ServiceType, TicketCategory if needed
