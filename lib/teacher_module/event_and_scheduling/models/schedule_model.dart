import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final String time;
  final String day; // AM/PM indicator
  final String date;
  final String title;
  final String venue;

  const ScheduleModel({
    required this.time,
    required this.day,
    required this.date,
    required this.title,
    required this.venue,
  });

  @override
  List<Object?> get props => [time, day, date, title, venue];
}
