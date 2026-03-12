import 'package:arrive_app/view_screens/EmojiMoodScreen.dart';
import 'package:flutter/material.dart';

class SelectColorScreen extends StatefulWidget {
  const SelectColorScreen({super.key});

  @override
  State<SelectColorScreen> createState() => _SelectColorScreenState();
}

class _SelectColorScreenState extends State<SelectColorScreen> {
  int selectedIndex = -1;

  final List<Color> colors = [
    const Color(0xFF88D8C0),
    const Color(0xFFF9D565),
    const Color(0xFFFE9C5E),
    const Color(0xFFADDEFA),
    const Color(0xFFB2FEB2),
    const Color(0xFFFA6830),
    const Color(0xFFC7CCF9),
    const Color(0xFF2E6FF3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// HEADER
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black), // Custom back arrow icon

                  onPressed: () {
                    Navigator.pop(context); // Default back action
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  "Select a color to rate",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  "2/3",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
              ],
            ),
            const Text(
              "your day!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 6),

            /// SUBTITLE
            const Text(
              "Choose one that you like most",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8E8E93),
              ),
            ),

            const SizedBox(height: 120),

            /// COLOR GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: ClipPath(
                    clipper: HexagonClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index],
                        border: selectedIndex == index
                            ? Border.all(
                          color: Colors.deepPurple,
                          width: 4,
                        )
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            /// SAVE BUTTON
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EmojiMoodScreen()));
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

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    return Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, h * 0.25)
      ..lineTo(w, h * 0.75)
      ..lineTo(w * 0.5, h)
      ..lineTo(0, h * 0.75)
      ..lineTo(0, h * 0.25)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
