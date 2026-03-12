import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String emailKey = 'email';
  static const String loginTimeKey = 'login_time';

  // Session duration: 7 days (in milliseconds)
  static const int sessionDuration = 7 * 24 * 60 * 60 * 1000;

  // Save user session after login
  static Future<void> saveUserSession(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(userIdKey, userData['user_id'] ?? 0);
    await prefs.setString(userNameKey, userData['user_name'] ?? '');
    await prefs.setString(emailKey, userData['email'] ?? '');
    await prefs.setInt(loginTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Check if session is valid (not expired)
  static Future<bool> isSessionValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? userId = prefs.getInt(userIdKey);
    final int? loginTime = prefs.getInt(loginTimeKey);

    if (userId == null || userId == 0 || loginTime == null) {
      return false;
    }

    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final bool isExpired = (currentTime - loginTime) > sessionDuration;

    if (isExpired) {
      await clearSession();
      return false;
    }

    return true;
  }

  // Load user session data
  static Future<Map<String, dynamic>> loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? userId = prefs.getInt(userIdKey);
    final String? userName = prefs.getString(userNameKey);
    final String? email = prefs.getString(emailKey);

    if (userId != null && userId != 0) {
      return {
        'user_id': userId,
        'user_name': userName ?? '',
        'email': email ?? '',
      };
    } else {
      return {};
    }
  }

  // Clear user session (logout)
  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
    await prefs.remove(userNameKey);
    await prefs.remove(emailKey);
    await prefs.remove(loginTimeKey);
  }

  // Logout user
  static Future<void> logout() async {
    await clearSession();
  }
}