import 'package:flutter/material.dart';

class YesNoScreen extends StatefulWidget {
  const YesNoScreen({super.key});

  @override
  _YesNoScreenState createState() => _YesNoScreenState();
}

class _YesNoScreenState extends State<YesNoScreen> {
  String? selectedOption;

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
                "Do you want to include Postpartum Journaling Mode?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
        
            // Selectable Container for "Yes"
            OptionField(
              text: "Yes",
              value: "Yes",
              selectedOption: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            const SizedBox(height: 15),
        
            // Selectable Container for "No"
            OptionField(
              text: "No",
              value: "No",
              selectedOption: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
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
  final String? selectedOption;
  final ValueChanged<String?> onChanged;

  const OptionField({
    super.key,
    required this.text,
    required this.value,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedOption == value
              ? Color(0xffDBF3EC)  // Change background color when selected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: selectedOption == value
                ? Color(0xff88D8C0)
                : Colors.black26,          ),
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
