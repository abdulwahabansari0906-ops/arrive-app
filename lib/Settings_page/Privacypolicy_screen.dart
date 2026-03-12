import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size to make responsive adjustments
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Set full screen background color to white

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section with back arrow icon
            Padding(
              padding:  EdgeInsets.only(top:screenHeight * 0.03),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context); // Handle back navigation
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.14,
                    ),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: screenWidth * 0.065, // Adjust font size based on screen width
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Space between title and content

            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "At Arrive, we respect and protect the privacy of our users. This Privacy Policy outlines the types of personal\ninformation we collect, how we use it,\nand how we protect your information.\n",
                      style: TextStyle(fontSize: screenWidth * 0.045), // Adjust font size
                    ),
                    SizedBox(height: screenHeight * 0.02), // Space between sections

                    Text(
                      "Information We Collect\n"
                          "When you use our app, we may collect the following types of personal information:\n"
                          "     * Device Information: We may collect information about the type of device you use, its operating system, and other technical details to help us improve our app.\n"
                          "     * Usage Information: We may collect information about how you use our app, such as which features you use and how often you use them.\n"
                          "     * Personal Information: We may collect personal information, such as your name, email address, or phone number, if you choose to provide it to us.\n",
                      style: TextStyle(fontSize: screenWidth * 0.045), // Adjust font size
                    ),
                    SizedBox(height: screenHeight * 0.02), // Space between sections

                    Text(
                      "How We Use Your Information\n"
                          "We use your information for the following purposes:\n"
                          "     * To provide and improve our app: We use your information to provide and improve our app, including to personalize your experience and to analyze how our app is used.\n"
                          "     * To communicate with you: We may use your information to communicate with you about our app, including to provide you with updates and news about our app.\n"
                          "     * To protect our rights and the rights of others: We may use your information to protect our rights and the rights of others, such as to investigate and prevent fraud or other illegal activity.\n",
                      style: TextStyle(fontSize: screenWidth * 0.045), // Adjust font size
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
