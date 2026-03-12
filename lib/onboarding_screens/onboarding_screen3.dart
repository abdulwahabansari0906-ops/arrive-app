import 'package:arrive_app/widget_screens/alertdiologe_screen2.dart';
import 'package:flutter/material.dart';
import 'onboarding_screen3_page1.dart';
import 'onboarding_screen3_page2.dart';
import 'onboarding_screen3_page3.dart';
import 'onboarding_screen3_page4.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final mqSize = MediaQuery.of(context).size;
  final PageController _pageController = PageController();
  int currentPage = 0;

  double get progress => (currentPage + 1) / 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔝 TOP SPACE (STATUS BAR LOOK)
            const SizedBox(height: 15),

            /// 🔝 PROGRESS BARS (THORA NEECHAY)
            /// 🔝 PROGRESS BARS (UPDATED WITH DIFFERENT GRADIENTS)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(4, (index) {

                  /// Different gradients for each container
                  List<List<Color>> gradients = [
                    [Color(0xFFECBD4F), Color(0xFFFD6E5C)], // Page 1
                    [Color(0xffFD6F5C), Color(0xffE227F9)],           // Page 2
                    [Color(0xffE42BF2), Color(0xff6A0EFF)],          // Page 3
                    [Color(0xff6E0FFF), Color(0xff008CE9)],           // Page 4
                  ];

                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: index <= currentPage
                          ? Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradients[index],
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                        ),
                      )
                          : null,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 8),

            /// 🔢 PERCENT TEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Color(0xFFFF5F6D),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const TextSpan(
                      text: ' of magic completed',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// ⬅️ BACK ARROW + TITLE (ONBOARDING KA HISSA)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (currentPage == 0) {
                        // Navigate to Get Started screen when on the first page
                        Navigator.pop(context);
                      } else {
                        // Go to previous page
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: mqSize.width * 0.15),
                  const Text(
                    'Sunday, October 6',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// 📄 CENTER CONTENT (PAGES)
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: [
                  OnboardingPage1(),
                  OnboardingPage2(),
                  OnboardingPage3(),
                  Onboardingpage4(),
                ],
              ),
            ),

            /// ⬇️ NEXT BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F1E27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Color(0xFF4CFF8F),
                        width: 1,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (currentPage == 3) {
                      // Show the alert dialog when the user clicks "Complete" on the last page
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CompletionDialog();
                        },
                      );
                    } else {
                      // Move to the next page
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    currentPage == 3 ? 'Complete' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
