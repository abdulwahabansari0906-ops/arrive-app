import 'package:flutter/material.dart';
class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using LayoutBuilder to handle different screen heights/widths
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStreakCircle(),
                    _buildHeader(),
                    const SizedBox(height: 5),
                    _buildCalendarRow(),
                    const SizedBox(height: 5),
                    _buildStatsCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStreakCircle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: Container(

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffF8FAFB),
              width: 3.0),
              color: Colors.transparent,
            ),
            child: Center(
              child: Image(image: AssetImage('assets/images/lets-icons_fire.png'), height: 111, width: 100,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: Text("4",style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Week Streak',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 0),
        Text(
          'You are doing really great, Anna!',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildCalendarRow() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final dates = ['', '', '01', '02', '03', '04', '05'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        bool isDone = index < 2; // Monday and Tuesday checked
        return Column(
          children: [
            Text(days[index], style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            isDone
                ? const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF90D5C3),
              child: Icon(Icons.check, size: 18, color: Colors.white),
            )
                : Text(
              dates[index],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      height: 176,
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFDFE7EC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Text("Your Stats", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
          Padding(
            padding: const EdgeInsets.only(left: 4.0,right: 4),
            child: Container(
              height: 145,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statItem("Days", "22"),
                      _statDivider(),
                      _statItem("Lessons", "36"),
                      _statDivider(),
                      _statItem("Quizzes", "18"),
                      _statDivider(),
                      _statItem("Minutes", "231"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: _buildInsightButton()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statDivider() {
    return Container(height: 30, width: 1, color: Colors.grey.shade300);
  }

  Widget _buildInsightButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.auto_awesome, size: 16, color: Colors.pinkAccent),
          SizedBox(width: 8),
          Text(
            "2 insights Available", // Fixed typo from original image
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ],
      ),
    );
  }
}