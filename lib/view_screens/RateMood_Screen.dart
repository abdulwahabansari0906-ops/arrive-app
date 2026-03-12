import 'package:arrive_app/view_screens/colorselection_screen.dart';
import 'package:arrive_app/widget_screens/custom%20Slider%20widget.dart';
import 'package:flutter/material.dart';

class RateMoodScreen extends StatefulWidget {
  const RateMoodScreen({super.key});

  @override
  State<RateMoodScreen> createState() => _RateMoodScreenState();
}

class _RateMoodScreenState extends State<RateMoodScreen> {
  double moodValue = 7.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 12),
            const Text(
              "Rate your mood",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Text("1/3", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "You can rate your mood from 1 to 10",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 50),

            /// HEXAGON
            ClipPath(
              clipper: HexagonClipper(),
              child: Container(
                height: 170,
                width: 170,
                color: const Color(0xFFFFFBF7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      moodValue.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text("mood rate",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// 🔥 CUSTOM SLIDER (SAME AS IMAGE)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orangeAccent),
                color: const Color(0xFFFFFBF7),
              ),
              child: Column(
                children: [
                  CustomMoodSlider(
                    value: moodValue,
                    onChanged: (v) {
                      setState(() => moodValue = v);
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            const Spacer(),

            /// SAVE BUTTON
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectColorScreen()));
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
