import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:http/http.dart' as http;
import '../../data/local_storage/local_storage_service.dart'; // Import LocalStorageService

class CalendarApiService {
  // Base URLs
  // final String baseUrl = dotenv.get('CORE_CALENDAR_URL');
  // final String upcomingUrl = dotenv.get('UPCOMING_CALENDAR_URL');
  final String baseUrl = 'https://stage-api-edudibon.trinodepointers.com';
  final String upcomingUrl = 'https://stage-api-edudibon.trinodepointers.com/core/calendar/upcoming';

  Future<String?> _getAccessToken() async {
    return await LocalStorageService.getAuthToken();
  }

  // Fetch Calendar Data
  Future<List<dynamic>> fetchCalendar() async {
    return _fetchData(baseUrl);
  }

  // Fetch Upcoming Events
  Future<List<dynamic>> fetchUpcomingEvents() async {
    return _fetchData(upcomingUrl);
  }

  // Generic Function to Fetch Data
  Future<List<dynamic>> _fetchData(String url) async {
    final accessToken = await _getAccessToken();
    if (accessToken == null) {
      print("Error: Authentication token not found.");
      return []; // Or throw an exception as appropriate for your error handling
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'] ?? [];
      } else {
        print("Error: Unexpected status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching data from $url: $e");
      return [];
    }
  }
}