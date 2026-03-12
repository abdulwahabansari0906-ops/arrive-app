import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  final String question;
  final String hint;

  const OnboardingPage({
    super.key,
    required this.question,
    required this.hint,
  });

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Controller for the TextField to track its input
  final TextEditingController _textController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Initialize the FocusNode to detect when the field is selected
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode()); // This will unfocus the TextField
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _dismissKeyboard();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.question,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            // TextField with conditional border color
            TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: widget.hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 2,
                    color: _focusNode.hasFocus && _textController.text.isNotEmpty
                        ? Color(0xff88D8C0) // Green border when selected and has text
                        : Colors.black26, // Grey border when unselected or no text
                  ),
                ),
              ),
              // Update the UI when text changes
              onChanged: (_) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
