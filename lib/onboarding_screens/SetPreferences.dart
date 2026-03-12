import 'package:flutter/material.dart';

class SetPreferencesScreen extends StatefulWidget {
  const SetPreferencesScreen({super.key});

  @override
  _SetPreferencesScreenState createState() => _SetPreferencesScreenState();
}

class _SetPreferencesScreenState extends State<SetPreferencesScreen> {
  String? selectedPreference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Align(
              alignment: Alignment.center,
              child: const Text(
                "Set your preferences for using Arrive",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
        
            // Selectable Container for AI Feedback Options
            OptionField(
              text: "AI feedback options",
              value: "AI feedback options",
              selectedPreference: selectedPreference,
              onChanged: (value) {
                setState(() {
                  selectedPreference = value;
                });
              },
            ),
            const SizedBox(height: 15),
        
            // Selectable Container for Therapist Recommendations
            OptionField(
              text: "Therapist recommendations",
              value: "Therapist recommendations",
              selectedPreference: selectedPreference,
              onChanged: (value) {
                setState(() {
                  selectedPreference = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionField extends StatelessWidget {
  final String text;
  final String value;
  final String? selectedPreference;
  final ValueChanged<String?> onChanged;

  const OptionField({
    super.key,
    required this.text,
    required this.value,
    required this.selectedPreference,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedPreference == value
              ? Color(0xffDBF3EC)  // Change background color when selected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedPreference == value
                ? Color(0xff88D8C0)
                : Colors.black26,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
