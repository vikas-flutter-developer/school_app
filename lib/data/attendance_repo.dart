// lib/attendance/data/attendance_repository.dart
import 'package:edudibon_flutter_bloc/api/api_client.dart';

import '../student_module/attendance&timetable&report/model/attendance_model.dart';
class AttendanceRepository {
  final ApiClient apiClient;

  AttendanceRepository({required this.apiClient});

  Future<List<CalendarEvent>> fetchCalendar(String fromDate, String toDate) async {
    final response = await apiClient.get('/core/calendar', queryParams: {
      'from_date': fromDate,
      'to_date': toDate,
    });
    return (response['data'] as List).map((json) => CalendarEvent.fromJson(json)).toList();
  }
}