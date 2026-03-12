
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/send_otp_service.dart';
import 'change_password_screen.dart';

class OtpScreenForChangePassword extends StatefulWidget {
  final String email;
  final int expectedOtp;

  const OtpScreenForChangePassword({
    super.key,
    required this.email,
    required this.expectedOtp,
  });

  @override
  State<OtpScreenForChangePassword> createState() =>
      _OtpScreenForChangePasswordState();
}

class _OtpScreenForChangePasswordState
    extends State<OtpScreenForChangePassword> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  String? _otpError;
  bool _isSubmitting = false;
  bool _isResending = false;

  // -1 means OTP is expired (user came back from ChangePassword screen)
  late int _currentExpectedOtp;

  bool get _isOtpExpired => _currentExpectedOtp == -1;

  @override
  void initState() {
    super.initState();
    _currentExpectedOtp = widget.expectedOtp;
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  // ─── Auto-focus next box ────────────────────────────────────────────────────

  void _onChanged(String value, int index) {
    if (_otpError != null) setState(() => _otpError = null);
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }

  // ─── Resend OTP ─────────────────────────────────────────────────────────────

  Future<void> _onResend() async {
    setState(() {
      _isResending = true;
      _otpError = null;
      for (var c in _controllers) c.clear();
    });
    FocusScope.of(context).requestFocus(_focusNodes[0]);

    try {
      final int newOtp = await SendOtpService.sendOtp(widget.email);
      if (!mounted) return;

      setState(() {
        _currentExpectedOtp = newOtp; // Activate fresh OTP
        _isResending = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP resent successfully!'),
          backgroundColor: Color(0xff122029),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isResending = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ─── Submit & Verify OTP ────────────────────────────────────────────────────

  Future<void> _onSubmit() async {
    // Block submit if OTP is expired — user must resend first
    if (_isOtpExpired) {
      setState(() => _otpError = 'OTP expired. Please resend a new code.');
      return;
    }

    final enteredOtp = _controllers.map((c) => c.text).join();

    if (enteredOtp.length < 4) {
      setState(() => _otpError = 'Please enter the complete 4-digit OTP');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _otpError = null;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    if (int.tryParse(enteredOtp) == _currentExpectedOtp) {
      setState(() => _isSubmitting = false);

      // ✅ Expire OTP immediately so if user comes back it won't work
      _currentExpectedOtp = -1;

      // Navigate and wait — if user pops back, OTP stays expired
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ChangePassword(
          email: widget.email,
          otp: enteredOtp,
        ),
      );

      // User came back from ChangePassword screen
      if (mounted) {
        setState(() {
          // Clear all boxes
          for (var c in _controllers) c.clear();
          _otpError = 'OTP expired. Please tap "Resend Code"\nto get a new code.';
        });
      }
    } else {
      setState(() {
        _isSubmitting = false;
        _otpError = 'Your OTP is incorrect';
      });
    }
  }

  // ─── OTP Box Widget ─────────────────────────────────────────────────────────

  Widget _otpBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        // Disable boxes when OTP is expired
        enabled: !_isOtpExpired,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          counterText: '',
          filled: _isOtpExpired,
          fillColor: _isOtpExpired ? Colors.grey.shade100 : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _otpError != null ? Colors.red : Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _otpError != null ? Colors.red : Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        onChanged: (value) => _onChanged(value, index),
      ),
    );
  }

  // ─── Submit Button ──────────────────────────────────────────────────────────

  Widget _submitButton() {
    return GestureDetector(
      onTap: (_isSubmitting || _isResending) ? null : _onSubmit,
      child: Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
            child: _isSubmitting
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : const Text(
              "Submit",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                // ─── Top Bar ─────────────────────────────────────────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    const Text(
                      "Add other email",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ─── Title ───────────────────────────────────────────────
                const Text(
                  "Add OTP to change\npassword",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Enter the 4-digit code we sent to",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 8),

                Text(
                  widget.email,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 25),

                // ─── OTP Boxes ───────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _otpBox(index)),
                ),

                // ─── Error / Expired Message ─────────────────────────────
                if (_otpError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _otpError!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isOtpExpired ? Colors.orange : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                // ─── Resend Code Button ──────────────────────────────────
                TextButton(
                  onPressed: (_isResending || _isSubmitting) ? null : _onResend,
                  child: _isResending
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xff122029),
                    ),
                  )
                      : Text(
                    "Resend code",
                    style: TextStyle(
                      fontSize: 16,
                      // Highlight resend when OTP is expired
                      color: _isOtpExpired
                          ?  Colors.blue
                          : Colors.blue,
                      fontWeight: _isOtpExpired
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),

                // ─── Change Email Button ─────────────────────────────────
                TextButton(
                  onPressed: (_isSubmitting || _isResending)
                      ? null
                      : () => Navigator.pop(context),
                  child: const Text(
                    "Change my email",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 30),

                // ─── Submit Button ───────────────────────────────────────
                _submitButton(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}