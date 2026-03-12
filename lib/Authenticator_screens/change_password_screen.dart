import 'package:arrive_app/Authenticator_screens/Loginbottemsheet.dart';

import 'package:flutter/material.dart';

import '../services/reset_password_service.dart';

class ChangePassword extends StatefulWidget {
  // Nullable — safe even if called without params from old code
  final String? email;
  final String? otp;

  const ChangePassword({
    super.key,
    this.email,
    this.otp,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ─── Validation ─────────────────────────────────────────────────────────────

  bool _validate() {
    String? passwordErr;
    String? confirmErr;

    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (password.isEmpty) {
      passwordErr = 'Please enter a new password';
    } else if (password.length < 8) {
      passwordErr = 'Password must be at least 8 characters';
    }

    if (confirm.isEmpty) {
      confirmErr = 'Please confirm your password';
    } else if (password != confirm) {
      confirmErr = 'Passwords do not match';
    }

    setState(() {
      _passwordError = passwordErr;
      _confirmPasswordError = confirmErr;
    });

    return passwordErr == null && confirmErr == null;
  }

  // ─── API Call ────────────────────────────────────────────────────────────────

  Future<void> _onChangePressed() async {
    if (!_validate()) return;

    // Guard — if email or otp not passed, show error
    final email = widget.email;
    final otp = widget.otp;

    if (email == null || email.isEmpty || otp == null || otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session expired. Please restart the reset process.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ResetPasswordService.resetPassword(
        email: email,
        otp: otp,
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      // ✅ Success → navigate to Login
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const LoginBottomSheet(),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // ─── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wScale = size.width / 375;
    final hScale = size.height / 812;
    final tScale = (wScale + hScale) / 2;

    const double fieldRadius = 10.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: 15 * wScale, left: 15 * wScale, right: 15 * wScale),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top bar ────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.only(top: 40 * hScale),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,
                          size: 22 * tScale, color: Colors.black),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 50 * wScale),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontFamily: 'B',
                        fontWeight: FontWeight.w700,
                        fontSize: 18 * tScale,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30 * hScale),

              // ── Lock icon ──────────────────────────────────────────────
              Icon(Icons.lock, size: 100 * tScale, color: Colors.black),

              SizedBox(height: 30 * hScale),

              // ── Title ──────────────────────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    fontFamily: 'B',
                    fontWeight: FontWeight.w700,
                    fontSize: 24 * tScale,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Your New Password Here...',
                  style: TextStyle(
                    fontFamily: 'B',
                    fontWeight: FontWeight.w700,
                    fontSize: 17 * tScale,
                  ),
                ),
              ),

              SizedBox(height: 20 * hScale),

              // ── Password field ─────────────────────────────────────────
              _PasswordField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: _obscurePassword,
                errorText: _passwordError,
                fieldRadius: fieldRadius,
                wScale: wScale,
                hScale: hScale,
                tScale: tScale,
                onToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                showVisibilityOn: !_obscurePassword,
              ),

              SizedBox(height: 14 * hScale),

              // ── Confirm Password field ─────────────────────────────────
              _PasswordField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: _obscureConfirmPassword,
                errorText: _confirmPasswordError,
                fieldRadius: fieldRadius,
                wScale: wScale,
                hScale: hScale,
                tScale: tScale,
                onToggle: () => setState(
                        () => _obscureConfirmPassword = !_obscureConfirmPassword),
                showVisibilityOn: !_obscureConfirmPassword,
              ),

              SizedBox(height: 24 * hScale),

              // ── Change Button ──────────────────────────────────────────
              GestureDetector(
                onTap: _isLoading ? null : _onChangePressed,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                    ),
                    borderRadius:
                    BorderRadius.circular(fieldRadius * wScale),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff122029),
                      borderRadius: BorderRadius.circular(
                          (fieldRadius - 1.5) * wScale),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        'Change',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 15 * tScale,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20 * hScale),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Reusable Password Field ─────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? errorText;
  final double fieldRadius;
  final double wScale;
  final double hScale;
  final double tScale;
  final VoidCallback onToggle;
  final bool showVisibilityOn;

  const _PasswordField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.errorText,
    required this.fieldRadius,
    required this.wScale,
    required this.hScale,
    required this.tScale,
    required this.onToggle,
    required this.showVisibilityOn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            // Red border on error, black otherwise
            color: errorText != null ? Colors.red : Colors.black,
            borderRadius: BorderRadius.circular(fieldRadius * wScale),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular((fieldRadius - 1.5) * wScale),
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              style:
              TextStyle(color: Colors.black, fontSize: 14 * tScale),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: onToggle,
                  icon: Icon(
                    showVisibilityOn
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 20 * tScale,
                    color: const Color(0xFFA4A4A4),
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'R',
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * tScale,
                  color: const Color(0xFFA4A4A4),
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      (fieldRadius - 1.5) * wScale),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      (fieldRadius - 1.5) * wScale),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 16 * hScale, horizontal: 20 * wScale),
              ),
            ),
          ),
        ),

        // Inline error text
        if (errorText != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 4 * wScale),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12 * tScale,
              ),
            ),
          ),
        ],
      ],
    );
  }
}