import 'package:arrive_app/Authenticator_screens/lgoinorsignup_screen.dart';
import 'package:arrive_app/feedback_portion/review_your_progress.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),  // Rounded corners for the dialog
      ),
      backgroundColor: Colors.white,  // White background for the dialog
      elevation: 10,  // Elevation to make the dialog pop out
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main Title text
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: const Text(
                "“Arrive” Would Like to Send You Notifications",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),  // Space between title and content text
            // Description text
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: const Text(
                "Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 5,),
            // Divider between content and buttons
            Divider(
              color: Colors.grey[400],
              thickness: 1,
              height: 2,
            ),
            // Buttons: "Don't Allow" and "Allow"
            Row(
              children: [

                /// Don't Allow Button
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginSignupScreen()),
                        );
                      },
                      child: const Text(
                        "Don’t Allow",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                /// Vertical Divider
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey.shade400,
                ),

                /// Allow Button
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewProgressScreen()),
                        );
                      },
                      child: const Text(
                        "Allow",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}