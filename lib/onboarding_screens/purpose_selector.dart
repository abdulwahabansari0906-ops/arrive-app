import 'package:flutter/material.dart';

class PurposeSelectionScreen extends StatefulWidget {
  const PurposeSelectionScreen({super.key});

  @override
  _PurposeSelectionScreenState createState() => _PurposeSelectionScreenState();
}

class _PurposeSelectionScreenState extends State<PurposeSelectionScreen> {
  String? selectedPurpose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Align(
                alignment: Alignment.center,
                child: const Text(
                  "What is the purpose of using Arrive?",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                OptionField(
                  text: "Self-reflection",
                  value: "Self-reflection",
                  selectedPurpose: selectedPurpose,
                  onChanged: (value) {
                    setState(() {
                      selectedPurpose = value;
                    });
                  },
                ),
                OptionField(
                  text: "Postpartum support",
                  value: "Postpartum support",
                  selectedPurpose: selectedPurpose,
                  onChanged: (value) {
                    setState(() {
                      selectedPurpose = value;
                    });
                  },
                ),
                OptionField(
                  text: "Mood improvement",
                  value: "Mood improvement",
                  selectedPurpose: selectedPurpose,
                  onChanged: (value) {
                    setState(() {
                      selectedPurpose = value;
                    });
                  },
                ),
                OptionField(
                  text: "Connecting with others",
                  value: "Connecting with others",
                  selectedPurpose: selectedPurpose,
                  onChanged: (value) {
                    setState(() {
                      selectedPurpose = value;
                    });
                  },
                ),
              ],
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
  final String? selectedPurpose;
  final ValueChanged<String?> onChanged;

  const OptionField({
    super.key,
    required this.text,
    required this.value,
    required this.selectedPurpose,
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
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedPurpose == value
              ? Color(0xffDBF3EC)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedPurpose == value
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
            // Custom Circle Radio Button with Checkmark
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selectedPurpose==value? Color(0xff88D8C0):Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                 border: Border.all(
                   color: selectedPurpose == value
                       ? Color(0xff88D8C0)
                       : Colors.grey,
                   width: 2,
                 ),
              ),
              child: selectedPurpose == value
                  ? const Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
