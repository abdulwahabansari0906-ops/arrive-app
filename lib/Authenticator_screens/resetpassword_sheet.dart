
import 'package:flutter/material.dart';

import '../services/send_otp_service.dart';
import 'otp_screen_for_change_password.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onResetPressed() async {
    final email = _emailController.text.trim();

    // Basic email validation
    if (email.isEmpty) {
      setState(() => _errorText = 'Please enter your email');
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() => _errorText = 'Please enter a valid email');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      // Call OTP service and get the OTP from API response
      final int receivedOtp = await SendOtpService.sendOtp(email);

      if (!mounted) return;

      setState(() => _isLoading = false);

      // Navigate to OTP screen, passing email and the OTP received from API
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => OtpScreenForChangePassword(
          email: email,
          expectedOtp: receivedOtp,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorText = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BaseSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(context: context, title: "Reset password"),

          const Text(
            "Enter the email you used when you registered and we will send an email with a link to help you change your password.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 18),

          // Email field with controller
          _FieldWithLabel(
            label: "Email",
            controller: _emailController,
            errorText: _errorText,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),

          // Reset password button
          GestureDetector(
            onTap: _isLoading ? null : _onResetPressed,
            child: _isLoading
                ? _loadingButton()
                : _primaryButton("Reset password"),
          ),
        ],
      ),
    );
  }
}

// ─── Base Sheet ────────────────────────────────────────────────────────────────

Widget _BaseSheet({required Widget child}) {
  return Builder(
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.92,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: child,
            ),
          );
        },
      );
    },
  );
}

// ─── Header ────────────────────────────────────────────────────────────────────

Widget _Header({required BuildContext context, required String title}) {
  return Column(
    children: [
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
      const SizedBox(height: 20),
    ],
  );
}

// ─── Text Field with Label ──────────────────────────────────────────────────────

class _FieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;

  const _FieldWithLabel({
    required this.label,
    required this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: label,
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Primary Button ─────────────────────────────────────────────────────────────

Widget _primaryButton(String text) {
  return Container(
    width: double.infinity,
    height: 48,
    padding: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xff98FF98), Color(0xff88D8C0)],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xff122029),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  );
}

// ─── Loading Button ─────────────────────────────────────────────────────────────

Widget _loadingButton() {
  return Container(
    width: double.infinity,
    height: 48,
    padding: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xff98FF98), Color(0xff88D8C0)],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xff122029),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      ),
    ),
  );
}