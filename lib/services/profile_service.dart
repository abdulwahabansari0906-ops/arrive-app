import 'dart:convert';
import 'package:http/http.dart' as http;

// ─── Model ────────────────────────────────────────────────────────────────────

class UpdateProfileRequest {
  final int userId;
  final String name;
  final String phone;
  final int age;

  const UpdateProfileRequest({
    required this.userId,
    required this.name,
    required this.phone,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'name':    name,
    'phone':   phone,
    'age':     age,
  };
}

class UpdateProfileResponse {
  final bool   isSuccess;
  final String message;

  const UpdateProfileResponse({
    required this.isSuccess,
    required this.message,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      isSuccess: (json['status'] as String?)?.toLowerCase() == 'success',
      message:   json['message'] as String? ?? '',
    );
  }
}

// ─── Service ──────────────────────────────────────────────────────────────────

class ProfileService {
  static const String _baseUrl = 'https://api.arrivejournal.com/public/api';
  static const Duration _timeout = Duration(seconds: 15);

  // ── Update Profile ───────────────────────────────────────────────────────────

  static Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest request) async {
    final Uri url = Uri.parse('$_baseUrl/update_profile');

    try {
      final http.Response response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept':       'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(_timeout);

      final Map<String, dynamic> json =
      jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateProfileResponse.fromJson(json);
      } else {
        // Server returned non-2xx — extract message if present
        return UpdateProfileResponse(
          isSuccess: false,
          message:   json['message'] as String? ??
              'Server error (${response.statusCode})',
        );
      }
    } on http.ClientException catch (e) {
      return UpdateProfileResponse(
          isSuccess: false, message: 'Network error: ${e.message}');
    } catch (e) {
      return UpdateProfileResponse(
          isSuccess: false, message: 'Unexpected error: $e');
    }
  }
}