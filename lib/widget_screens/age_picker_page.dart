import 'package:flutter/material.dart';

class AgePickerPage extends StatefulWidget {
  const AgePickerPage({super.key});

  @override
  State<AgePickerPage> createState() => _AgePickerPageState();
}

class _AgePickerPageState extends State<AgePickerPage> {
  final FixedExtentScrollController _scrollController =
  FixedExtentScrollController(initialItem: 18);

  int selectedAge = 36;

  @override
  Widget build(BuildContext context) {
    // Get screen orientation (portrait or landscape)
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: isLandscape ? Axis.horizontal : Axis.vertical, // Scroll horizontally in landscape mode
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// QUESTION
            const Text(
              "What is your age?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 30),

            /// AGE PICKER
            SizedBox(
              height: 220,
              width: isLandscape ? 400 : double.infinity, // Ensure full width in portrait, fixed in landscape
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// SELECTION LINES
                  Positioned(
                    top: 90,
                    child: Container(
                      width: 120,
                      height: 2,
                      color: const Color(0xff9EE5C1),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    child: Container(
                      width: 120,
                      height: 2,
                      color: const Color(0xff9EE5C1),
                    ),
                  ),

                  /// SCROLL WHEEL
                  ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: 44,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() => selectedAge = index + 1);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final age = index + 1;
                        final isSelected = age == selectedAge;

                        return Center(
                          child: Text(
                            age.toString(),
                            style: TextStyle(
                              fontSize: isSelected ? 30 : 18,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey.shade500,
                            ),
                          ),
                        );
                      },
                      childCount: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
