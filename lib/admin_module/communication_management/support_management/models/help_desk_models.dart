class Ticket {
  final String id;
  final String title;
  final String status;
  final String category;
  final String raisedBy;
  final String date;
  final String issue;

  Ticket({
    required this.id,
    required this.title,
    required this.status,
    required this.category,
    required this.raisedBy,
    required this.date,
    required this.issue,
  });
}

class Survey {
  final String name;
  final String startDate;
  final String endDate;

  Survey({required this.name, required this.startDate, required this.endDate});
}
