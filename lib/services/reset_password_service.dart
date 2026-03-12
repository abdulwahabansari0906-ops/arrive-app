import 'dart:convert';
import 'package:http/http.dart' as http;

class ResetPasswordService {
  static const String _baseUrl = 'https://api.arrivejournal.com/public/api';

  /// Reset password using email, otp, new password and confirmation.
  /// Returns success message on success, throws exception on failure.
  static Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    final Uri url = Uri.parse('$_baseUrl/reset_password');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'otp': otp,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        return data['message'] as String;
      } else {
        throw Exception(data['message'] ?? 'Password reset failed');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}