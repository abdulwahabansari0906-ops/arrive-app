import 'package:flutter/material.dart';

class CustomMoodSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomMoodSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final position = (value - 1) / 9 * width;

        return GestureDetector(
          onPanUpdate: (details) {
            double dx = details.localPosition.dx.clamp(0, width);
            double newValue = 1 + (dx / width) * 9;
            onChanged(newValue);
          },
          onTapDown: (details) {
            double dx = details.localPosition.dx.clamp(0, width);
            double newValue = 1 + (dx / width) * 9;
            onChanged(newValue);
          },
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              /// TRACK with gradient - single line
              Container(
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFA6830), // Red
                      Color(0xFFFE9C5E), // Orange
                      Color(0xFFF9D565), // Yellow
                      Color(0xFFB2FEB2), // Green
                      Color(0xFF88D8C0), // Green

                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              /// Tick marks
              // Positioned.fill(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: List.generate(10, (index) {
              //       return Container(
              //         width: 2,
              //         height: 16,
              //         color: index == 0 || index == 9
              //             ? (index == 0
              //             ? const Color(0xFFE74C3C)
              //             : const Color(0xFF52C17D))
              //             : const Color(0xFFF39C12),
              //       );
              //     }),
              //   ),
              // ),

              /// Vertical lines at the left, center (25%, 50%, 75%), and right
              Positioned(
                left: 0,
                top: 5,
                bottom: 5,
                child: Container(
                  width: 2,
                  color: Color(0xffF3531E),
                ),
              ),
              Positioned(
                left: width * 0.34 - 2.5,
                top: 5,
                bottom: 5,
                child: Container(
                  width: 2,
                  color: Color(0xffFCAB07),
                ),
              ),
              Positioned(
                left: width * 0.67 - 2,
                top: 5,
                bottom: 5,
                child: Container(
                  width: 2,
                  color: Color(0xffF9D565),
                ),
              ),
              Positioned(
                left: width - 2,
                top: 5,
                bottom: 5,
                child: Container(
                  width: 2,
                  color: Color(0xff2CC575),
                ),
              ),

              /// THUMB
              Positioned(
                left: position - 10,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF52C17D),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),

              /// Labels (1 and 10) - only once at bottom, aligned beneath the bar
              Positioned(
                left: 0,
                bottom: -25,
                child: Text(
                  '1',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: -25,
                child: Text(
                  '10',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
