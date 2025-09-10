import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:http/http.dart' as http;
import '../../data/local_storage/local_storage_service.dart'; // Import LocalStorageService

class AvatarApiService {
  static  String _baseUrl = dotenv.get('USER_AVATAR_URL');

  Future<String?> _getAccessToken() async {
    return await LocalStorageService.getAuthToken();
  }

  Future<String?> fetchAvatar(int imageSize) async {
    final String url = '$_baseUrl/$imageSize';
    final accessToken = await _getAccessToken();

    if (accessToken == null) {
      print("Error: Authentication token not found.");
      return null; // Or throw an exception
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['avatar']; // Returns the base64 string
      } else {
        print("Error fetching avatar: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}