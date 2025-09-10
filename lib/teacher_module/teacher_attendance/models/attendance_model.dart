class AttendanceData {
  final String date;
  final String status;

  AttendanceData({required this.date, required this.status});
}

class AttendanceSummary {
  final int present;
  final int absent;
  final int late;
  final int halfDay;

  AttendanceSummary({
    required this.present,
    required this.absent,
    required this.late,
    required this.halfDay,
  });
}
