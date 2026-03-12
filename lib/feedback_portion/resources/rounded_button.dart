import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // The thickness of your border
    const double borderThickness = 1.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        // 1. This outer decoration acts as the "Border"
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff98FF98),
              Color(0xff88D8C0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        // 2. The padding creates the visible width of the border
        padding: const EdgeInsets.all(borderThickness),
        child: Container(
          // 3. This inner decoration is the actual button background
          decoration: BoxDecoration(
            color: const Color(0xff122029), // Your background color
            borderRadius: BorderRadius.circular(12 - borderThickness),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}