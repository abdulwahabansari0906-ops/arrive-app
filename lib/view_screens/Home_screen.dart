import 'package:flutter/material.dart';

import '../Music_screen/Musicadd_screen.dart';
import '../sessions/session_manager.dart';
import 'Getstarted_screen.dart';
import 'Getstarted_screen2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  Key _sheetKey = const ValueKey('day');

  int selectedDay = 2;
  bool showBottomDates = false;

  bool isDaySelected = true;
  double sheetHeight = 0.83;

  String userName = "";

  @override
  void initState() {
    super.initState();
    _loadUserSession();
  }

  void _loadUserSession() async {
    final userSession = await SessionManager.loadUserSession();
    setState(() {
      // user_name from new API (e.g. "test user") — show first word only
      final fullName = userSession['user_name'] ?? "Anna";
      userName = fullName.toString().split(' ').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F7F2),
      body: SafeArea(
        child: Stack(
          children: [
            // ================= TOP HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hi, $userName!",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: Color(0xff2EC598),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDaySelected = true;
                                      sheetHeight = 0.83;
                                      _sheetKey = const ValueKey('day');
                                    });
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          _sheetController.animateTo(
                                            0.83,
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeOut,
                                          );
                                        });
                                  },
                                  child: _toggleButton("Day", isDaySelected),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDaySelected = false;
                                      sheetHeight = 0.58;
                                      _sheetKey = const ValueKey('month');
                                    });
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          _sheetController.animateTo(
                                            0.58,
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeOut,
                                          );
                                        });
                                  },
                                  child: _toggleButton("Month", !isDaySelected),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 30,
                            width: 30,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(
                                width: 1,
                                color: Color(0xff2EC598),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notification_add_outlined,
                              color: Color(0xff2EC598),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _DayText("M"),
                      _DayText("T"),
                      _DayText("W"),
                      _DayText("T"),
                      _DayText("F"),
                      _DayText("S"),
                      _DayText("S"),
                    ],
                  ),

                  const SizedBox(height: 4),
                  _dateGrid(isWhite: false),
                ],
              ),
            ),

            // ================= DRAGGABLE WHITE SHEET =================
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: sheetHeight,
              minChildSize: 0.56,
              maxChildSize: isDaySelected ? 0.90 : 0.75,
              builder: (context, scrollController) {
                scrollController.addListener(() {
                  if (scrollController.offset > 50 && !showBottomDates) {
                    setState(() => showBottomDates = true);
                  } else if (scrollController.offset <= 50 && showBottomDates) {
                    setState(() => showBottomDates = false);
                  }
                });

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Journal ❤️",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            _clickableJournalCard(
                              title: "How do you\nfeel today?",
                              subtitle: "Journaling",
                              imagePath: "assets/images/homebookimage.png",
                              color: const Color(0xFFF4F2D3),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetStartedScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            _clickableJournalCard(
                              title: "Mood\nchecker",
                              subtitle: "Tracker",
                              imagePath: "assets/images/homemugimage.png",
                              color: const Color(0xFFEAE7FF),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetStartedScreen2(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicaddScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDAF2F6),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Daily motivation",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Inspirational phrases for your day",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ================= RECOMMENDED FOR YOU =================
                        const Text(
                          "Recommended for you",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            _recommendCard(
                              "Focus",
                              "Daily task",
                              "assets/images/ima1.jpg",
                            ),
                            const SizedBox(width: 12),
                            _recommendCard(
                              "Happiness",
                              "Daily task",
                              "assets/images/ima2.jpg",
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // ================= GET INSPIRE FROM OTHER =================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Get inspire from other",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.headphones,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Dark featured card
                        Container(
                          height: 190,
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black87.withOpacity(0.5), Color(0xff2E6FF3)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 30),
                              Text(
                                "How to Fight Depression",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Daily Habits That\nMake a Difference.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // News list items
                        _inspireNewsItem(
                          category: "Lifehacks",
                          time: "4 hours ago",
                          description:
                              "The Role of Support Systems in Mental Wellness. Having a solid support system is crucial in fighting depr....",
                        ),
                        _inspireDivider(),
                        _inspireNewsItem(
                          category: "Lifehacks",
                          time: "4 hours ago",
                          description:
                              "The Power of Movement in Combating Depression. Exercise is not just for physical fitness – it's a proven mental...",
                        ),
                        _inspireDivider(),
                        _inspireNewsItem(
                          category: "Lifehacks",
                          time: "4 hours ago",
                          description:
                              "Nature's Role in Mental Health. Spending time in nature can reduce stress and promote happiness.",
                        ),
                        _inspireDivider(),
                        _inspireNewsItem(
                          category: "Lifehacks",
                          time: "4 hours ago",
                          description:
                              "The Healing Power of Self-Care. Self-care is more than spa days and bubble baths.",
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ================= INSPIRE NEWS ITEM =================
  Widget _inspireNewsItem({
    required String category,
    required String time,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                category,
                style: const TextStyle(
                  color: Color(0xFF2E6FF3),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.circle, size: 10, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _inspireDivider() {
    return const Divider(color: Color(0xFFEEEEEE), thickness: 1, height: 1);
  }

  // ================= DATE GRID =================
  Widget _dateGrid({required bool isWhite}) {
    return Column(
      children: List.generate((31 / 7).ceil(), (rowIndex) {
        final start = rowIndex * 7 + 1;
        final end = (start + 6 > 31) ? 31 : start + 6;
        final isLastRow = end == 31;

        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            mainAxisAlignment: isLastRow
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: List.generate(end - start + 1, (i) {
              final day = start + i;
              final isSelected = day == selectedDay;

              return Padding(
                padding: EdgeInsets.only(right: isLastRow ? 14 : 0),
                child: GestureDetector(
                  onTap: () => setState(() => selectedDay = day),
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2EC598)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      day.toString().padLeft(2, '0'),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  // ================= TOGGLE BUTTON =================
  Widget _toggleButton(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: active ? const Color(0xff2EC598) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ================= CLICKABLE JOURNAL CARD =================
  Widget _clickableJournalCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 189,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  imagePath,
                  width: 55,
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 0),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "1–2 min",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      backgroundColor: Colors.white,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF20C997),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendCard(String title, String subtitle, String imagepath) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F7),
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: AssetImage(imagepath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= DAY LABEL =================
class _DayText extends StatelessWidget {
  final String text;

  const _DayText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    );
  }
}
