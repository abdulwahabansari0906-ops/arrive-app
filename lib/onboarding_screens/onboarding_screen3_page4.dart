import 'package:flutter/material.dart';
class Onboardingpage4 extends StatefulWidget {
  const Onboardingpage4({super.key});

  @override
  State<Onboardingpage4> createState() => _Onboardingpage4State();
}

class _Onboardingpage4State extends State<Onboardingpage4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4), // Shadow position
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Happy day',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7A88),
                ),
              ),
              const SizedBox(height: 7),

              // Tags
              Row(
                children: const [
                  _TagChip(label: 'Happy'),
                  _TagChip(label: 'Party'),
                  _TagChip(label: 'Walking'),
                ],
              ),
              const SizedBox(height: 13),

              // Description
              const Text(
                'Today felt like pure joy—I started the morning with a warm cup of coffee and watched the sunrise. In the afternoon, I took a long walk in the park, feeling the crisp air and the sound of leaves crunching underfoot. The day ended perfectly with a heartfelt conversation with a friend, leaving me full of gratitude.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7A88),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🟦 TAG CHIP
class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 9),
      ),
    );
  }
}
