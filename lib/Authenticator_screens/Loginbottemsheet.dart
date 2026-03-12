import 'package:arrive_app/Authenticator_screens/resetpassword_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:arrive_app/services/login_service.dart';
import '../Settings_page/Privacypolicy_screen.dart';
import '../sessions/session_manager.dart';
import '../view_screens/Bottemnavigation_screen.dart';

class LoginBottomSheet extends StatefulWidget {
  final bool isFromLogout;

  const LoginBottomSheet({super.key, this.isFromLogout = false});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  bool isChecked = false;
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await LoginService.loginUser(
      emailController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (result['status'] == true) {
      await SessionManager.saveUserSession(result);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainBottomNavigation()),
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.isFromLogout,
      onPopInvoked: (didPop) {
        if (!didPop && widget.isFromLogout) {
          SystemNavigator.pop(); // sirf logout ke baad app band
        }
      },
      child: DraggableScrollableSheet(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Email field
                  _fieldWithLabel("Email", controller: emailController),

                  // Password field
                  _fieldWithLabel("Password", isPassword: true, controller: passwordController),

                  const SizedBox(height: 10),

                  // Forgot password
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const ResetPasswordBottomSheet(),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Forgot password? Reset",
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Checkbox + Terms
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: isChecked ? Colors.green : Colors.transparent,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: isChecked
                              ? const Icon(Icons.check, color: Colors.white, size: 15)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                            children: <TextSpan>[
                              const TextSpan(text: "I agree to the "),
                              TextSpan(
                                text: "Fitness Terms of Service",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("Terms of Service clicked");
                                  },
                              ),
                              const TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PrivacyPolicy()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Login button
                  GestureDetector(
                    onTap: _login,
                    child: Container(
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
                            isLoading ? "Logging in..." : "Log in",
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "Or continue with:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Social login buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _containerBox(imagePath: "assets/images/apple.png"),
                      const SizedBox(width: 10),
                      _containerBox(imagePath: "assets/images/facebook.png"),
                      const SizedBox(width: 10),
                      _containerBox(imagePath: "assets/images/google.png"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _fieldWithLabel(String label,
    {bool isPassword = false, required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _containerBox({required String imagePath}) {
  return Container(
    width: 50,
    height: 48,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(width: 1, color: const Color(0xff697C88)),
    ),
    child: Center(
      child: Image.asset(imagePath, height: 27, width: 27),
    ),
  );
}