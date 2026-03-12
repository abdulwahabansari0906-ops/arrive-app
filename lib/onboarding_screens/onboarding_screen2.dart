import 'package:arrive_app/inspiration/artical_view_screen.dart';
import 'package:arrive_app/inspiration/inspiration_feed.dart';
import 'package:flutter/material.dart';
import 'package:arrive_app/onboarding_screens/SetPreferences.dart';
import 'package:arrive_app/onboarding_screens/purpose_selector.dart';
import 'package:arrive_app/onboarding_screens/yes&no_screen.dart';
import '../widget_screens/alertdiologe_screen.dart';  // Importing the custom alert dialog
import 'onboarding_data.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final FixedExtentScrollController _ageController =
  FixedExtentScrollController(initialItem: 35);
  int selectedAge = 36;

  // Flag to control visibility of the back button
  bool showBackButton = false;

  // Method to dismiss the keyboard
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode()); // Unfocus the TextField to dismiss the keyboard
  }

  // Method to show the bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 480,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 49,
                  width: 49,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff9B9996), Color(0xff2B2B2A)],
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Allow notifications",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Stay connected to your spiritual journey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Orbikular",
                    color: Color(0xff4A5451),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 118,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 26.45,
                              width: 25.19,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.3),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            const Text(
                              "Arrive",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Check Your Weekly Progress 🌟",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Set a reminder to review your weekly progress and stay on the path to achieving your goals.",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InspirationFeed()));
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff36454F), // Inside color of the container
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Allow",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    _showAlertDialog(); // Show the AlertDialog when "Maybe later" is clicked
                  },
                  child: const Text(
                    "Maybe later",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff162C26),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to show the AlertDialog when "Maybe later" is clicked
  void _showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing by tapping outside
      barrierColor: Colors.black.withOpacity(0.6), // Dims the background (0.6 opacity)
      builder: (BuildContext context) {
        return const CustomAlertDialog(); // Show the custom alert dialog
      },
    );
  }

  // Method to handle the visibility of the back button
  void _toggleBackButtonVisibility() {
    if (currentIndex == 0 && showBackButton) {
      setState(() {
        showBackButton = false; // Hide back button on the first page
      });
    } else if (currentIndex > 0 && !showBackButton) {
      setState(() {
        showBackButton = true; // Show back button when user interacts with text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mqsize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              /// TOP PROGRESS LINE
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: LinearProgressIndicator(
                  value: (currentIndex + 1) / onboardingItems.length,
                  backgroundColor: Colors.grey.shade300,
                  color: const Color(0xff9EE5C1),
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              /// BACK + PAGE COUNT
              /// BACK + PAGE COUNT
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// BACK BUTTON (Space Always Reserved)
                    Visibility(
                      visible: showBackButton,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: GestureDetector(
                        onTap: () {
                          if (currentIndex > 0) {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.arrow_back_ios, size: 14),
                              SizedBox(width: 4),
                              Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// PAGE COUNT (Always Right Side)
                    Text(
                      "${currentIndex + 1}/${onboardingItems.length}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff88D8C0),
                      ),
                    ),
                  ],
                ),
              ),


              /// PAGES
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: onboardingItems.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                    _toggleBackButtonVisibility(); // Update back button visibility based on the page index
                  },
                  itemBuilder: (context, index) {
                    /// 🔹 AGE PAGE (index = 1)
                    if (index == 1) {
                      return Column(
                        children: [
                          const SizedBox(height: 60),
                          const Text(
                            "What is your age?",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 240,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                /// TOP LINE
                                Positioned(
                                  top: 95,
                                  child: Container(
                                    width: 120,
                                    height: 2,
                                    color: const Color(0xff9EE5C1),
                                  ),
                                ),
                                /// BOTTOM LINE
                                Positioned(
                                  bottom: 95,
                                  child: Container(
                                    width: 120,
                                    height: 2,
                                    color: const Color(0xff9EE5C1),
                                  ),
                                ),
                                /// AGE WHEEL
                                ListWheelScrollView.useDelegate(
                                  controller: _ageController,
                                  itemExtent: 44,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      selectedAge = value + 1;
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 100,
                                    builder: (context, i) {
                                      final age = i + 1;
                                      final isSelected = age == selectedAge;

                                      return Center(
                                        child: Text(
                                          age.toString(),
                                          style: TextStyle(
                                            fontSize: isSelected ? 30 : 18,
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            color: isSelected ? Colors.black : Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    /// 🔹 PAGE 3 (What is the purpose of using Arrive?)
                    if (index == 2) {
                      return const PurposeSelectionScreen(); // Purpose Selection screen
                    }

                    /// 🔹 PAGE 4 (Set preferences for using Arrive)
                    if (index == 3) {
                      return const SetPreferencesScreen(); // Set preferences screen
                    }

                    /// 🔹 PAGE 5 (Do you want to include Postpartum Journaling Mode?)
                    if (index == 4) {
                      return const YesNoScreen(); // YesNoScreen for Postpartum Journaling Mode
                    }

                    /// 🔹 NORMAL PAGES
                    final item = onboardingItems[index];
                    return OnboardingPage(
                      question: item.question,
                      hint: item.hint,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    /// 🔥 1️⃣ Keyboard Close
                    FocusScope.of(context).unfocus();

                    /// 🔥 2️⃣ Thora delay takay keyboard animation complete ho jaye
                    await Future.delayed(const Duration(milliseconds: 200));

                    /// 🔥 3️⃣ Navigation Logic
                    if (currentIndex == onboardingItems.length - 1) {
                      _showBottomSheet();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    height: 48,
                    width: mqsize.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff36454F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
