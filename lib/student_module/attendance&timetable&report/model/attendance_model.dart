// lib/attendance/data/attendance_model.dart
class CalendarEvent {
  final String cdate;
  final String dayOfWeek;
  final String dayType;
  final String description;
  final int id;
  final String name;

  CalendarEvent({
    required this.cdate,
    required this.dayOfWeek,
    required this.dayType,
    required this.description,
    required this.id,
    required this.name,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      cdate: json['cdate'],
      dayOfWeek: json['day_of_week'],
      dayType: json['day_type'],
      description: json['description'],
      id: json['id'],
      name: json['name'],
    );
  }

  get status => null;
}