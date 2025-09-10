class Leave {
  final String type;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;
  final String status;

  Leave({
    required this.type,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
  });
}
