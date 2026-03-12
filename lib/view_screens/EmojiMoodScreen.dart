import 'package:arrive_app/widget_screens/alertdiologe_screen2.dart';
import 'package:flutter/material.dart';

class EmojiMoodScreen extends StatefulWidget {
  const EmojiMoodScreen({super.key});

  @override
  State<EmojiMoodScreen> createState() => _EmojiMoodScreenState();
}

class _EmojiMoodScreenState extends State<EmojiMoodScreen> {
  int selectedIndex = 4;

  final List<String> labels = [
    "Angry",
    "Sad",
    "Neutral",
    "Happy",
    "Super",
  ];

  final List<String> emojis = [
    "😠",
    "😞",
    "😐",
    "😊",
    "😄",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// HEADER
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),

            const Spacer(),
            const Text(
              "How do you feel today?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
            const Spacer(),
            const Text(
              "3/3",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 6),

            /// SUBTITLE
            const Text(
              "Choose emoji that suits you",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF8E8E93),
              ),
            ),

            const SizedBox(height: 70),

            /// BIG EMOJI CIRCLE
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE9FBF4),
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF8FE0C3),
                  ),
                ),
                Text(
                  emojis[selectedIndex],
                  style: const TextStyle(fontSize: 90),
                ),
              ],
            ),

            const SizedBox(height: 60),

            /// EMOJI SELECTOR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(emojis.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedIndex == index
                              ? const Color(0xFF8FE0C3)
                              : Colors.white,
                          border: Border.all(
                            color: selectedIndex == index
                                ? Colors.transparent
                                : const Color(0xFFDADFE3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            emojis[index],
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: selectedIndex == index
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const Spacer(),
            GestureDetector(
              onTap: (){
                showDialog(
                          context: context,
                           builder: (BuildContext context) {
                             return const CompletionDialog();
                           },
                         );
              },
              child: Container(
                height: 48,
                width:double.infinity,
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
                      "Save",
                      style: TextStyle(color: Colors.white,fontSize: 16), // Text color
                    ),
                  ),
                ),
              ),
            ),

            /// SAVE BUTTON
            // SizedBox(
            //   width: double.infinity,
            //   height: 58,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF0D1B2A),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //     ),
            //     onPressed: () {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return const CompletionDialog();
            //         },
            //       );
            //     },
            //     child: const Text(
            //       "Save",
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
