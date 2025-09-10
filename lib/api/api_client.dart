// lib/core/api/api_client.dart
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/local_storage/local_storage_service.dart';

class ApiClient {
  // final String? baseUrl = dotenv.get('BASE_URL');
  final String? baseUrl = "https://stage-api-edudibon.trinodepointers.com";

  Future<String?> _getAccessToken() async {
    return await LocalStorageService.getAuthToken();
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
    // Check if baseUrl is null
    if (baseUrl == null || baseUrl!.isEmpty) {
      throw Exception('BASE_URL is not configured. Check your .env file and ensure it is loaded.');
    }

    final accessToken = await _getAccessToken();
    if (accessToken == null) {
      throw Exception('Authentication token not found. Please log in again.');
    }

    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}