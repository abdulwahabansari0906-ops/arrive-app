import 'package:flutter/material.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  /// ✅ UNIQUE TAGS ONLY
  final List<String> allTags = [
    'Happy',
    'Party',
    'Walking',
    'Workout',
    'Family',
    'Friends',
    'Travel',
    'Relax',
    'Study',
    'Work',
    'Nature',
    'Music',
    'Food',
  ];

  /// ✅ STARTING SELECTED TAGS
  final List<String> selectedTags = ['Happy', 'Party', 'Walking'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🟦 NAME YOUR DAY (NO CHANGE)
          Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name your day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7A88),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    label: const Text("Happy day"),
                    filled: true,
                    fillColor: const Color(0xFFF4F7F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// 🟦 TAG YOUR DAY (AUTO HEIGHT – GROWS)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tag your day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7A88),
                  ),
                ),
                const SizedBox(height: 9),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Wrap(
                    spacing: 7,
                    runSpacing: 10,
                    children: selectedTags.map((tag) {
                      return _SelectedTag(
                        label: tag,
                        onRemove: () {
                          setState(() {
                            selectedTags.remove(tag);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// 🟦 TAGS TITLE
          const Text(
            'Tags',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7A88),
            ),
          ),
          const SizedBox(height: 12),

          /// 🟦 ALL TAGS (CLICK TO ADD)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: allTags.map((tag) {
              return GestureDetector(
                onTap: () {
                  if (!selectedTags.contains(tag)) {
                    setState(() {
                      selectedTags.add(tag);
                    });
                  }
                },
                child: _TagChip(label: tag),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// 🟪 SELECTED TAG CHIP
class _SelectedTag extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _SelectedTag({
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E8FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 16),
          ),
        ],
      ),
    );
  }
}

/// 🟦 NORMAL TAG CHIP
class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
