import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String apiUrl = "https://api.arrivejournal.com/public/api/arrive_login";

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == 'success') {
        return {
          'status': true,
          'message': responseBody['message'] ?? 'Login successful!',
          'user_id': responseBody['user_id'],
          'user_name': responseBody['user_name'],
          'email': email, // ✅ yahan email add ki
        };
      } else {
        return {
          'status': false,
          'message': responseBody['message'] ?? 'Failed to login. Please try again.',
        };
      }
    } catch (e) {
      return {'status': false, 'message': 'An error occurred: $e'};
    }
  }
}