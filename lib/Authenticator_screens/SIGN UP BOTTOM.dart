import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:arrive_app/Services/arrive_service.dart';
import 'package:arrive_app/Settings_page/Privacypolicy_screen.dart';
import 'package:arrive_app/Authenticator_screens/Loginbottemsheet.dart';

class SignupBottomSheet extends StatefulWidget {
  const SignupBottomSheet({super.key});

  @override
  State<SignupBottomSheet> createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  bool isChecked = false;
  bool isLoading = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final ArriveService _arriveService = ArriveService();

  // Register User function
  void _registerUser() async {
    setState(() {
      isLoading = true; // Show the loader
    });

    final response = await _arriveService.registerUser(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );

    setState(() {
      isLoading = false; // Hide the loader
    });

    if (response['status'] == true) {
      // Successfully registered
      print('User registered successfully');
      // Redirect to Login screen after successful registration
      Navigator.pop(context); showModalBottomSheet( context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => const LoginBottomSheet(), );



    } else {
      // Registration failed
      print('Error: ${response['message']}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text(response['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BaseSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(context: context, title: "Create account"),
          _fieldWithLabel("First name", controller: firstNameController),
          _fieldWithLabel("Last name", controller: lastNameController),
          _fieldWithLabel("Email", controller: emailController),
          _fieldWithLabel("Password", controller: passwordController, isPassword: true),
          _fieldWithLabel("Confirm Password", controller: confirmPasswordController, isPassword: true),

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
                      ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  )
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
                          color: Colors.black,
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
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicy(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              _registerUser();
            },
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _primaryButton("Sign Up"),
          ),

          const SizedBox(height: 15),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                "or continue with",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _threeContainers(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Base sheet with DraggableScrollableSheet
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
            child: SingleChildScrollView(controller: controller, child: child),
          );
        },
      );
    },
  );
}

// Header with close button
Widget _Header({required BuildContext context, required String title}) {
  return Column(
    children: [
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context); // <-- dismiss bottom sheet
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
      const SizedBox(height: 5),
    ],
  );
}

// Text field widget with label
Widget _fieldWithLabel(String label, {bool isPassword = false, required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 17),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: "$label",
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

// Primary button widget
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

// Three containers below the form
Widget _threeContainers() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _containerBox(imagePath: "assets/images/apple.png"), // First image
      SizedBox(width: 8),
      _containerBox(imagePath: "assets/images/facebook.png"), // Second image
      SizedBox(width: 8),
      _containerBox(imagePath: "assets/images/google.png"), // Third image
    ],
  );
}

// Container widget with an image
Widget _containerBox({required String imagePath}) {
  return Container(
    width: 50,
    height: 48,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(width: 1, color: const Color(0xff697C88)),
    ),
    child: Image.asset(imagePath, height: 25, width: 25),
  );
}