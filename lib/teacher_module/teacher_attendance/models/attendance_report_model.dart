class AttendanceReport {
  final String studentId;
  final String studentName;
  final Map<String, String> attendance;

  AttendanceReport({
    required this.studentId,
    required this.studentName,
    required this.attendance,
  });
}
