import 'package:arrive_app/feedback_portion/resources/rounded_button.dart';
import 'package:arrive_app/feedback_portion/week_streak.dart';
import 'package:flutter/material.dart';

class ReviewProgressScreen extends StatefulWidget {
  const ReviewProgressScreen({super.key});

  @override
  State<ReviewProgressScreen> createState() => _ReviewProgressScreenState();
}

class _ReviewProgressScreenState extends State<ReviewProgressScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 7.0),
          child: const Text(
            'Review your progress',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: const Icon(Icons.ios_share, color: Colors.black,size: 32,),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMoodFlowCard(screenWidth, screenHeight),
                const SizedBox(height: 20),
                _buildStatsGrid(screenWidth),
                const SizedBox(height: 30),
                const Text(
                  'Recommendations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                _buildImproveMoodCard(),
                const SizedBox(height: 20),
                _buildInsightCard(),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: RoundedButton(title: 'Find a therapist', onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StreakScreen()));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Mood Flow Section ---
  Widget _buildMoodFlowCard(double screenWidth, double screenHeight) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mood Flow',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildDropdown2('week'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: screenHeight * 0.2,
            child: Row(
              children: [
                _buildEmojiYAxis(),
                Expanded(child: _buildChartArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiYAxis() {
    final List<String> emojis = [
      'assets/images/2.png',
      'assets/images/Emoji1.png',
      'assets/images/Emoji.png',
      'assets/images/Emoji (1).png',
      'assets/images/Emoji 4.png',
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: emojis.map((path) {
        return SizedBox(
          height: 16.98,
          child: Image.asset(
            path,
            fit: BoxFit.contain,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChartArea() {
    final dates = ['10/1', '10/6', '10/11', '10/16', '10/21', '10/26', '10/29'];

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: dates.map((date) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: 1.2,
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                ),
              ],
            );
          }).toList(),
        ),
        _buildChartImage(Alignment(-1.0, -0.6), 'assets/images/2.png'),
        _buildChartImage(Alignment(-0.66, 0.1), 'assets/images/Emoji.png'),
        _buildChartImage(Alignment(-0.33, -0.85), 'assets/images/2.png'),
      ],
    );
  }

  Widget _buildChartImage(Alignment alignment, String assetPath) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        height: 24,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // --- Stats Grid Section ---
  Widget _buildStatsGrid(double screenWidth) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 2.2,
      children: [
        _statTile(
          title: 'Current streak',
          value: '1 day',
          imagePath: 'assets/images/LogoTrophy 4.png',
        ),
        _statTile(
          title: 'Longest streak',
          value: '7 day',
          imagePath: 'assets/images/2 (1).png',
        ),
        _statTile(
          title: 'Entries made',
          value: '18 day',
          imagePath: 'assets/images/gift.png',
        ),
        _statTile(
          title: 'Entries made',
          value: '18 day',
          imagePath: 'assets/images/2.png',
        ),
      ],
    );
  }

  Widget _statTile({
    required String title,
    required String value,
    String? imagePath,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (imagePath != null)
            Image.asset(
              imagePath,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            )
          else if (icon != null)
            Icon(icon, color: Colors.orangeAccent, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff122029),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Recommendation Section ---
  Widget _buildImproveMoodCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Improve your mood',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: 0.4,
                      strokeWidth: 3,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: 0.6,
                      strokeWidth: 3,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'You have marked your mood as bad for 4 days in a row',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Take a tack',
                        style: TextStyle(
                          color: Colors.teal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _miniStat('4 days', 'bad mood', Colors.teal),
              _miniStat('8 hours', 'sleep', Colors.blue),
              _miniStat('16 days', 'good mood', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff2EC598),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Insight',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Row(
                children: [
                  _buildDropdown('week', color: Color(0xffF8FAFB)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      // Action for menu
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xffF8FAFB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '+78%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Your mood has improved a lot this week!\nKeep it up!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your mood is better than 50% of users',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              const Icon(Icons.arrow_back_ios, color: Colors.white54, size: 12),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: List.generate(5, (i) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 3,
                        decoration: BoxDecoration(
                          color: i == 1 ? Colors.white : Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, {Color color = const Color(0xffF8FAFB)}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }

  Widget _buildDropdown2(String label, {Color color = const Color(0xff2EC598)}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white),
        ],
      ),
    );
  }

  Widget _miniStat(String val, String label, Color col) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 2, height: 12, color: col),
            const SizedBox(width: 4),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
