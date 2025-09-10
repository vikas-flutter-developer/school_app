import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  static const String _authTokenKey = 'authToken';

  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_authTokenKey);
  }

  static Future<bool> setAuthToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_authTokenKey, token);
  }

  static Future<bool> clearAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(_authTokenKey);
  }

// Add other methods for saving/retrieving different data if needed
}