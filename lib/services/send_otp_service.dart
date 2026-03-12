import 'dart:convert';
import 'package:http/http.dart' as http;

class SendOtpService {
  static const String _baseUrl = 'https://api.arrivejournal.com/public/api';

  /// Send OTP to the given email address.
  /// Returns the OTP integer on success, throws an exception on failure.
  static Future<int> sendOtp(String email) async {
    final Uri url = Uri.parse('$_baseUrl/send_otp');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        // API returns the OTP directly in the response
        return data['otp'] as int;
      } else {
        throw Exception(data['message'] ?? 'Failed to send OTP');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}