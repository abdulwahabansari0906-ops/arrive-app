import 'dart:convert';
import 'package:http/http.dart' as http;

class ArriveService {
  // Base URL for the API
  static const String baseUrl = 'https://api.arrivejournal.com/public/api/arrive_register';

  // Function to register a new user
  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': '$firstName $lastName',
          'email': email,
          'password': password,
        }),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseBody['status'] == 'success') {
          return {
            'status': true,
            'message': responseBody['message'] ?? 'User registered successfully',
            'user': responseBody['user'],
          };
        } else {
          return {
            'status': false,
            'message': responseBody['message'] ?? 'Registration failed.',
          };
        }
      } else {
        return {
          'status': false,
          'message': responseBody['message'] ?? 'Failed to register user.',
        };
      }
    } catch (e) {
      print("Error: $e");
      return {
        'status': false,
        'message': 'An error occurred. Please try again later.',
      };
    }
  }
}